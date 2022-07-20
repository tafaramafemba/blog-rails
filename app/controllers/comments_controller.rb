class CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find_by(id: @comment.post_id)
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to user_posts_path(current_user, @post.id), notice: 'Comment was successfully deleted.' }
    end
  end
end
