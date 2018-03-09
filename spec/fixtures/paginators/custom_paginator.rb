class CustomPaginator < Resourcey::Paginator
  permit_params :from, :to

  def setup(opts)
    @from = opts[:from]
    @to = opts[:to]
  end

  def paginate(scope)
    offset = from
    limit = (to - from) + 1
    scope.offset(from - 1).limit(limit)
  end

  private

  attr_reader :from, :to
end
