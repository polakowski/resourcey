module Resourcey
  class Paginator
    class_attribute :allowed_params

    def initialize(params)
      parsed_params = parse_params(params)
      setup(parsed_params)
    end

    def parse_params(params)
      params.permit(self.allowed_params)
    end

    def paginate(*args)
      raise Errors::NotImplemented.new(:paginate)
    end

    def setup(*args)
      raise Errors::NotImplemented.new(:setup)
    end

    private

    class << self
      def class_for(name)
        paginator_name = "#{name.to_s.camelize}Paginator"
        paginator_name.safe_constantize || raise(Errors::ClassNotFound.new(paginator_name))
      end

      def permit_params(*args)
        self.allowed_params = args
      end
    end
  end
end

class PagedPaginator < Resourcey::Paginator
  permit_params :page, :per_page

  def setup(opts)
    @page = opts[:page].to_i
    @per_page = opts[:per_page].to_i
  end

  def paginate(scope)
    offset = (page - 1) * per_page
    scope.offset(offset).limit(per_page)
  end

  private

  attr_reader :page, :per_page
end

class OffsetPaginator < Resourcey::Paginator
  permit_params :offset, :limit

  def setup(opts)
    @offset = opts[:offset]
    @limit = opts[:limit]
  end

  def paginate(scope)
    scope.offset(offset).limit(limit)
  end

  private

  attr_reader :offset, :limit
end
