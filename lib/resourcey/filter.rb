module Resourcey
  class Filter
    class_attribute :allowed_params
    class_attribute :filters

    def initialize(params)
      @permitted_params = params.permit(allowed_params)
    end

    def apply(scope)
      @permitted_params.each do |filter_name, permitted_param|
        current_filter = filters.find { |filter| filter.name == filter_name }
        scope = current_filter.apply(permitted_param, scope)
      end

      scope
    end

    class << self
      def filter(filter_name, opts = {}, &block)
        self.allowed_params ||= []
        self.allowed_params << filter_name

        self.filters ||= []
        self.filters << build_filter(filter_name, opts, &block)
      end

      def build_filter(filter_name, opts, &block)
        FilterProcessor.new(filter_name, opts, &block)
      end
    end
  end
end
