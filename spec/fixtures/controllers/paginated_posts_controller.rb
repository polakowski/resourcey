class PaginatedPostsController < Resourcey::Controller
  use_model Post
  paginate
  serialize_with PostSerializer
end
