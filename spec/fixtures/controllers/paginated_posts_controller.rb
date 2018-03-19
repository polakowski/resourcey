class PaginatedPostsController < Resourcey::Controller
  use_model Post
  paginate

  # temporary solution until configurable serializer comes in
  def serializer
    PostSerializer
  end
end
