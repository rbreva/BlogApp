require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  before { subject.save }

  it 'Name must not be blank' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it 'Name must be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Post counter should be an integer' do
    subject.posts_counter = 'not-numeric'
    expect(subject).to_not be_valid
  end

  it 'Post should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Subject should be an instance of the class User' do
    expect(subject).to be_instance_of User
  end

  it 'The Method recent_posts should be available for the instance subject' do
    expect(subject).to respond_to(:recent_posts)
  end

  it 'Recent posts should return the last three posts' do
    expect(subject.recent_posts).to eq(subject.posts.last(3))
  end
end
