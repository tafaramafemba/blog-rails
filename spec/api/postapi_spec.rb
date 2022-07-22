require 'swagger_helper'

describe 'Posts API' do
  path 'api/v1/posts' do
    post 'Creates a post' do
      tags 'Posts'
      consumes 'application/json', 'application/xml'
      parameter title: :post, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          text: { type: :string },
        },
        required: [ 'title', 'text' ]
      }

      response '201', 'post created' do
        let(:post) {{ title: 'First post', text: 'This is my first post'}}
        run_test!
      end

      response '422', 'invalid request' do
        let(:post) {{ title: 'First post'}}
        run_test!
      end
    end
  end
end