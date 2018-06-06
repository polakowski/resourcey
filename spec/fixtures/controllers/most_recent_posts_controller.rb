class MostRecentPostsController < Resourcey::Controller
  use_model :post
  collection_scope &:most_recent
  serialize_with PostSerializer
end
