require 'active_model_serializers'
require 'active_model/serializer'

module Resourcey
  class Serializer < ActiveModel::Serializer
    attribute :id
  end
end
