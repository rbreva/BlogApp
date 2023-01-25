require 'rails_helper'

RSpec.describe PostsController, type: :request do
  it 'Expect render index' do
    get '/users/1/posts'
    expect(response).to render_template(:index)
    expect(response).to have_http_status(200)
    expect(response.body).to include('User Number One')
  end

  it 'Expect render from Show' do
    get '/users/1/posts/1'
    expect(response).to render_template(:show)
    expect(response).to have_http_status(200)
    expect(response.body).to include('by Username')
  end
end
