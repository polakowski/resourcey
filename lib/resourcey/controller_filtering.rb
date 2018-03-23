module Resourcey
  module ControllerFiltering
    def filtered_resources
      return resources if filter_class.nil?

      filter_instance = filter_class.new(params)
      filter_instance.apply(resources)
    end

    private

    def filter_class
      "#{resource_model}Filter".safe_constantize
    end
  end
end
