class CustomPaginator < Resourcey::Paginator
  permit_params :from_to

  def setup(opts)
    @from, @to = opts[:from_to].split(',').map(&:to_i)
  end

  def paginate(scope)
    offset = from - 1
    limit = (to - from) + 1
    scope.offset(offset).limit(limit)
  end

  private

  attr_reader :from, :to
end
