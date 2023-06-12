class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blank_name

  def index
    @following_users = current_user.following
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_path(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    sign_out(current_user)  # Cerrar la sesión del usuario actual
    redirect_to root_path  # Redirigir a la página principal u otra página de tu elección
  end

  def total_likes(user)
    user.posts.sum { |post| post.get_upvotes.size }
  end

  def profile
    @user = User.find(params[:id])
    @total_likes = total_likes(@user)
  end


  def liked_posts
    @liked_posts = current_user.find_liked_items
  end

  def set_blank_name
    if current_user.name == nil
      current_user.name = current_user.email.split('@').first
    end
  end
 
  private

  def user_params
    params.require(:user).permit(:name, :bio, :user_photo, :cover, :id)
  end


  
end
