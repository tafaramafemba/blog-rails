require 'rails_helper'

RSpec.describe Comment, type: :model do

  it  'Method should return the updated comments_counter' do
    counter = post.comments_counter
    subject.save
    expect(post.comments_counter).to eq(counter + 1)
  end
end