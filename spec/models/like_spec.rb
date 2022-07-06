require 'rails_helper'

RSpec.describe Like, type: :model do

  it  'Method should return the updated likes_counter' do
    counter = post.likes_counter
    subject.save
    expect(post.likes_counter).to eq(counter + 1)
  end
end