require 'rails_helper'

RSpec.describe 'Show User', type: :feature do

  describe 'Post' do
    before(:each) do
      @user = User.create!(name: 'Thomas', photo: 'https://unsplash.com/photos/F_0BxGuVvo', 
        bio: 'Teacher from Hungary.', postscounter: 0)

      @user2 = User.create!(name: 'Jinding', photo: 'https://unsplash.com/photos/F_0BxGuVvo', 
        bio: 'Teacher from Jamaica.', postscounter: 0)

      @post = @user.posts.create!(title: 'My post', text: 'this is my first post', 
        comments_counter: 0, likes_counter: 0)

      @post2 = @user2.posts.create!(title: 'Last post', text: 'this is my last post', 
        comments_counter: 0, likes_counter: 0)

    @comment = @post.comments.create!(text: 'This is a comment for a post', user_id: @user.id)
    @comment2 = @post2.comments.create!(text: 'This is a comment for the second user', user_id: @user2.id)


    @like = @post.likes.create!(user_id: @user.id)
    @like2 = @post2.likes.create!(user_id: @user2.id)

    visit user_posts_path(@user)
    end

  end
end