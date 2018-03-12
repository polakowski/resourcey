class InvalidPaginator < Resourcey::Paginator
  permit_params :foo

  def setup(opts)
    @foo = opts[:foo]
  end

  private

  attr_reader :foo
end
