class User < ActiveRecord::Base
  validates :name, :age, presence: true
  validates :age, numericality: { greater_than: 0 }, allow_nil: true

  has_many :posts
end
