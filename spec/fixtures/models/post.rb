class Post < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true

  scope :most_recent, -> { where('posts.created_at > ?', 2.days.ago) }
end
