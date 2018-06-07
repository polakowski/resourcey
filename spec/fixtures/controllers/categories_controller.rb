class CategoriesController < Resourcey::Controller
  configure_serialization do |config|
    config.action :index, serializer: CategorySerializer::Slim
    config.action :show, serializer: CategorySerializer::Show
    config.default serializer: CategorySerializer::Base
  end
end
