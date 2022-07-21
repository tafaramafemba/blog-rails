class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: params[:id]).where(author_id: params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter
    @post.likes_counter

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(current_user, @post), notice: 'Post was successfully created.' }
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def like
    @post = Post.find(params[:id])
    Like.new(user: current_user, post: @post).save
    redirect_to user_posts_path(current_user)
  end

  def comment
    @post = Post.find(params[:id])
    p params
    @comment = Comment.new(user: current_user, post: @post, text: params[:text])
    @comment.save
    authorize! :create, @comment
    redirect_to user_posts_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    @comment = @post.comments.where(post_id: @post.id)
    @like = @post.likes.where(post_id: @post.id)
    @comment.each(&:destroy)
    @like.each(&:destroy)
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_path, notice: 'Post was successfully removed.' }
    end
  end
end
