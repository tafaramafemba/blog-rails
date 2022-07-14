class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: params[:id]).where(author_id: params[:user_id])
  end
end

def new
  @post = Post.new
  @user = current_user
end

def create
  @post = Post.new(post_params)
  @post.user = current_user
  if @post.save
    puts @post
    redirect_to user_posts_path(current_user)
  else
    render :new
  end
end
