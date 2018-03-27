module Resourcey
  module Errors
    class BaseError < StandardError; end

    class NotImplemented < BaseError; end
    class ClassNotFound < BaseError; end
    class OptionNotAllowed < BaseError; end
    class RuntimeError < BaseError; end
  end
end
