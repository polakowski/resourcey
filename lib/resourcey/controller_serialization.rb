module Resourcey
  module ControllerSerialization
    extend ActiveSupport::Concern

    class Configuration
      attr_reader :actions_serializers
      attr_accessor :fallback_serializer

      def initialize
        @actions_serializers = Hash.new.with_indifferent_access
        @fallback_serializer = nil
      end

      def action(action_name, opts = {})
        @actions_serializers[action_name] = opts[:serializer]
      end

      def default(opts = {})
        @fallback_serializer = opts[:serializer]
      end

      def get_serializer_for_action(action_name)
        actions_serializers[action_name] || fallback_serializer
      end
    end

    included do
      class_attribute :serialization_config
    end

    module ClassMethods
      def serialize_with(serializer_name)
        self.serialization_config ||= Configuration.new
        self.serialization_config.fallback_serializer =
          serializer_name.to_s.classify.constantize
      end

      def configure_serialization
        return unless block_given?
        self.serialization_config ||= Configuration.new
        yield(self.serialization_config)
        self.serialization_config
      end
    end

    def build_serializer_from_configuration
      return if serialization_config.nil?
      serialization_config.get_serializer_for_action(action_name)
    end
  end
end
