class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = current_user.comments.new(comment_params)
    puts "id del post abak"
    puts @comment.post_id
    if !@comment.save
        flash[:notice] = @comment.errors.full_messages.to_sentence
    end

    redirect_to post_path(params[:post_id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
        @comment.destroy
        redirect_to post_path(@comment.post), notice: "Comentario eliminado correctamente."
      else
        redirect_to post_path(@comment.post), alert: "No tienes permiso para eliminar este comentario."
      end
  end
  

  private

  def comment_params
    params.require(:comment)
      .permit(:content)
      .merge(post_id: Post.friendly.find(params[:post_id]).id)
  end
  
end
