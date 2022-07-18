class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
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
    @post.comments_counter = 0
    @post.likes_counter = 0

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(@post.author_id, @post), notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
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
    redirect_to user_posts_path(current_user)
  end
end
