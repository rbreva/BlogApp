class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :post_counter, numericality: { greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id

  def recent_posts
    posts.limit(3).order(created_at: :desc)
  end
end
