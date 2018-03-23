module Resourcey
  class Filter
    class_attribute :allowed_params
    class_attribute :filters

    def initialize(params)
      @permitted_params = params.permit(self.allowed_params)
    end

    def apply(scope)
      @permitted_params.each do |filter_name, value|
        filter = self.filters.find { |filter| filter[:name] == filter_name }
        scope = filter[:block].call(value, scope)
      end

      scope
    end

    class << self
      def filter(filter_name, &block)
        self.allowed_params ||= []
        self.allowed_params << filter_name

        self.filters ||= []
        self.filters << build_filter(filter_name, &block)
      end

      def build_filter(filter_name, &block)
        {
          name: filter_name.to_s,
          block: block
        }
      end
    end
  end
end
