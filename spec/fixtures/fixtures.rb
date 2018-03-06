require 'active_record'

class User < ActiveRecord::Base
  validates :name, :age, presence: true
  validates :age, numericality: { greater_than: 0 }, allow_nil: true
end

class UsersController < Resourcey::Controller

  private

  def resource_params
    params.require(:user).permit(:name, :age)
  end
end

class UserSerializer < Resourcey::Serializer
  attributes :name, :age
end
