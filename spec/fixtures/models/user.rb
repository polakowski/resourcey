class User < ActiveRecord::Base
  validates :name, :age, presence: true
  validates :age, numericality: { greater_than: 0 }, allow_nil: true

  has_many :posts

  before_destroy :check_for_posts

  def check_for_posts
    errors.add(:base, 'cannot destroy user with posts') and throw(:abort) if posts.any?
  end
end
