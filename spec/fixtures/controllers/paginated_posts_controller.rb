class PaginatedPostsController < Resourcey::Controller
  paginate

  # temporary solution until configurable resource comes in
  def resource_model
    Post
  end

  # temporary solution until configurable serializer comes in
  def serializer
    PostSerializer
  end
end
