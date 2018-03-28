module Resourcey
  module ControllerModel
    extend ActiveSupport::Concern

    included do
      class_attribute :controller_model
    end

    module ClassMethods
      def use_model(model_or_name)
        self.controller_model = model_or_name.to_s.classify.constantize
      end
    end
  end
end
