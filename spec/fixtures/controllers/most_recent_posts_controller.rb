class MostRecentPostsController < Resourcey::Controller
  use_model :post
  collection_scope &:most_recent

  configure_serialization do |config|
    config.default serializer: PostSerializer
  end
end
