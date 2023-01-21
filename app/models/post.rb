class Post < ApplicationRecord
  has_many :comments
  has_many :likes

  belongs_to :author, class_name: 'User'

  after_save :update_posts_counter

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  private

  def update_posts_counter
    author.increment!(:post_counter)
  end
end
