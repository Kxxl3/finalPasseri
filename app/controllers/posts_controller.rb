class PostsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy upvote]


  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

 

  def upvote
    if current_user.voted_up_on? @post
      @post.unvote_by current_user
    else
      @post.upvote_by current_user
    end
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.turbo_stream
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  def like
    @post = Post.friendly.find(params[:post_id])
    if current_user.liked? @post
      @post.unliked_by current_user
    else
      @post.liked_by current_user
    end
    respond_to do |format|
      format.js
    end
  end

  def para_ti
    @users = User.all
  end

  def seguidos
    @following_users = current_user.following
  end
  

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to para_ti_path, notice: "Se ha subido la canción correctamente" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to para_ti_path, notice: "Se ha eliminado la canción correctamente" }
      format.json { head :no_content }
    end
  end

  

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :title, :file, :photo)
    end

    def create_like_notification(post, user)
      unless @post.user == user
        notification = post.user.notifications.create(
          recipient: post.user,
          actor: user,
          action: 'liked',
          notifiable: post
        )
        notification.send_notification
      end
    end
end
