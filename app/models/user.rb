class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :likes
  validates :name, presence: true
  validates :postscounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.limit(3).order(created_at: :desc)
  end

  def admin?(requested_role)
    role == requested_role.to_s
  end
end
