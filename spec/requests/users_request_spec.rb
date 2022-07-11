require 'rails_helper'

RSpec.describe 'Test index action', type: :request do
  before(:example) { get users_path }
  it 'is a success' do
    expect(response).to have_http_status(:ok)
  end
  it "renders 'index' template" do
    expect(response).to render_template('index')
  end

  it 'should display the correct placeholder text' do
    expect(response.body).to include('Here is a list of all users')
  end
end

RSpec.describe 'Test show action' do
  before(:example) do
    @user = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_0BxGuVvo', bio: 'Teacher from Mexico.')
    get user_path(@user)
  end

  it 'is a success' do
    expect(response).to have_http_status(:ok)
  end
  it "renders 'show' template" do
    expect(response).to render_template(:show)
  end

  it 'should display the correct placeholder text' do
    expect(response.body).to include('Here is a user')
  end
end
