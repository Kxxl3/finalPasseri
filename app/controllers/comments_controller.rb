class CommentsController < ApplicationController
  before_action :authenticate_user!

  # Método para crear un comentario
  def create
    # Se crea un nuevo comentario asociado al usuario actual
    @comment = current_user.comments.new(comment_params)
    
    # Si el comentario no se guarda correctamente, se muestra un mensaje de error
    if !@comment.save
      flash[:notice] = @comment.errors.full_messages.to_sentence
    end
    
    # Se redirige a la página del post donde se hizo el comentario
    redirect_to post_path(params[:post_id])
  end

  # Método para eliminar un comentario
  def destroy
    # Se busca el comentario por su ID
    @comment = Comment.find(params[:id])
    
    # Se verifica que el usuario actual sea el autor del comentario
    if current_user == @comment.user
      # Se elimina el comentario
      @comment.destroy
      
      # Se redirige de vuelta a la página del post con un mensaje de éxito
      redirect_to post_path(@comment.post), notice: "Comentario eliminado correctamente."
    end
  end

  private

  # Método privado para definir los parámetros permitidos para el comentario
  def comment_params
    params.require(:comment)
      .permit(:content)
      .merge(post_id: Post.friendly.find(params[:post_id]).id)
  end
end
