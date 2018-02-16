require 'active_record'

class User < ActiveRecord::Base

end

class UsersController < Resourcey::Controller

end

class UserSerializer < Resourcey::Serializer
  attribute :name
end
