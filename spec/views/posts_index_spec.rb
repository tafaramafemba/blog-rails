require 'rails_helper'

RSpec.describe 'Show User', type: :feature do

  describe 'Post' do
    before(:each) do
      @user = User.create!(name: 'John', photo: 'https://unsplash.com/photos/F_0BxGuVvo', 
        bio: 'Teacher from USA.', postscounter: 0)

      @user2 = User.create!(name: 'James', photo: 'https://unsplash.com/photos/F_0BxGuVvo', 
        bio: 'Teacher from Ghana.', postscounter: 0)

      @post = @user.posts.create!(title: 'My post', text: 'this is my first post', 
        comments_counter: 0, likes_counter: 0)

    @comment = @post.comments.create!(text: 'This is a comment for a post', user_id: @user.id)

    @like = @post.likes.create!(user_id: @user.id)

    visit user_posts_path(@user)
    end

  end
end