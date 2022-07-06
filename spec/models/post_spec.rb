require 'rails_helper'

RSpec.describe Post, type: :model do
  first_user = 'Tafara'
  subject {Post.new(user: first_user, title: 'Hello', text: 'This is my first post')}

  before {subject.save}

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not_be_valid
  end

  it 'title should not have morethan 250 characters' do
    subject.title = 'a' * 255
    expect(subject).to_not_be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = 'string'
    expect(subject).to_not_be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = 'string'
    expect(subject).to_not_be_valid
  end

  it  'Method should return the 3 most recent posts' do
    5.times { Comment.create(user: subject, post: subject, text: 'Comment text') }
    expect(subject.recent_posts.size).to eq(5)
  end

  it  'Method should return the updated comments_counter' do
    counter = user.posts_counter
    subject.save
    expect(user.posts_counter).to eq(counter + 1)
  end
end