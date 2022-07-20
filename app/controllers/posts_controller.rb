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
        format.html { redirect_to user_post_path(@post.user_id, @post), notice: 'Post was successfully created.' }
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

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_path, notice: 'Post was successfully removed.' }
    end
  end

  def destroy_comment
    @comment = Comment.find(params[:id])
    @post = Post.find_by(id: @comment.post_id)
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to user_post_path(current_user.id, @post.id), notice: 'Comment was successfully deleted.' }
    end
  end
end
