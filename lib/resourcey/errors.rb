module Resourcey
  module Errors
    class BaseError < StandardError; end

    class NotImplemented < BaseError
      def initialize(method_name)
        super("Please implement `#{method_name}`")
      end
    end

    class ClassNotFound < BaseError
      def initialize(class_name)
        super("Could not find class `#{class_name}`")
      end
    end

    class OptionNotAllowed < BaseError
      def initialize(option)
        super("Option `#{option}` is not allowed")
      end
    end
  end
end
