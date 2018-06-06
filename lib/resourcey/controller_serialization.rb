module Resourcey
  module ControllerSerialization
    extend ActiveSupport::Concern

    class Configuration
      def action(action_name, opts = {})

      end

      private


    end

    included do
      class_attribute :controller_serializer

    end

    module ClassMethods
      def serialize_with(serializer_name)
        self.controller_serializer = serializer_name.to_s.classify.constantize
      end

      # def configure_serialization
      #   return unless block_given?
      #
      # end
    end

    def build_serializer_from_configuration
      return controller_serializer if controller_serializer
      # get_action_serializer
    end

    # def get_action_serializer
    #
    # end
  end
end
