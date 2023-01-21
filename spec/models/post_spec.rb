require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.new(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.',
      post_counter: 1
    )
  end

  let(:subject) do
    Post.new(
      author: user,
      title: 'Hello',
      text: 'This is my first post',
      comments_counter: 2,
      likes_counter: 1
    )
  end

  it 'Title must not be blankcharacters' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'Title must not exceed 250 characters' do
    expect(subject.title).to be_a(String)
    expect(subject.title.length).to be <= 250
  end

  it 'Comments counter should be an integer' do
    subject.comments_counter = 'not-numeric'
    expect(subject).to_not be_valid
  end

  it 'Likes counter should be an integer' do
    subject.likes_counter = 'not-numeric'
    expect(subject).to_not be_valid
  end

  it 'Comments should be greater than or equal to 0' do
    subject.comments_counter = -4
    expect(subject).to_not be_valid
  end

  it 'Subject should be an instance of the class Post' do
    expect(subject).to be_instance_of Post
  end

  it 'The method recent_comments should be available for the instance subject' do
    expect(subject).to respond_to(:recent_comments)
  end
end