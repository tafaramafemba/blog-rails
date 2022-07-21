class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_destroy :delete_posts_counter
  after_save :update_posts_counter

  def update_posts_counter
    user.increment!(:postscounter)
  end

  def delete_posts_counter
    user.decrement!(:postscounter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
