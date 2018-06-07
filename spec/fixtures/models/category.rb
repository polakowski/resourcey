class Category < ActiveRecord::Base
  belongs_to :moderator, class_name: 'User'
  has_many :categories
  has_many :posts
end
