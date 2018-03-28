class MostRecentPostsController < Resourcey::Controller
  use_model :post
  collection_scope &:most_recent

  # temporary solution until configurable serializer comes in
  def serializer
    PostSerializer
  end
end
