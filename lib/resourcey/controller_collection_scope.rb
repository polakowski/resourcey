module Resourcey
  module ControllerCollectionScope
    extend ActiveSupport::Concern

    included do
      class_attribute :scoping_method
    end

    def scoped_resources
      return paginated_resources if scoping_method.nil?
      scoping_method.call paginated_resources
    end

    module ClassMethods
      def collection_scope(&block)
        self.scoping_method = block
      end
    end
  end
end
