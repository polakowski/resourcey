module Resourcey
  module ControllerModel
    extend ActiveSupport::Concern

    included do
      class_attribute :controller_model
    end

    module ClassMethods
      def use_model(model)
        self.controller_model = model
      end
    end
  end
end
