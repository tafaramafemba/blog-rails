module Api
  module V1
    class CommentsController < ApplicationController
      def index
        @comments = Comment.where(post_id: params[:post_id]).where(user_id: params[:user_id]).order(:created_at)
        render json: {
          success: true, message: "Successfully loaded comments", data: { comments: @comments }
        }
      end

      def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params, user_id: params[:user_id])

        if @comment.save
          render json: { success: true, message: 'Successfully created comment', data: { comment: @comment } }, status: :created
        else
          render json: { success: false, errors: @comment.errors }, status: :unprocessable_entity
        end
      end
      rescue ActiveRecord::RecordNotFound
        no_record(params[:post_id])
      end

      private

      def no_record(post)
        render json: { success: false, message: "This post: #{post} does not exist" }, status: :not_found
      end

      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end 

