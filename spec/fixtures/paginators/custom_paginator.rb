class CustomPaginator < Resourcey::Paginator
  permit_params :from_to

  def setup(opts)
    @from, @to = opts[:from_to].split(',').map(&:to_i)
  end

  def paginate(scope)
    offset = from
    limit = (to - from) + 1
    scope.offset(from - 1).limit(limit)
  end

  private

  attr_reader :from, :to
end
