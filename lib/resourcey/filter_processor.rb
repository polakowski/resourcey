module Resourcey
  class FilterProcessor
    ALLOWED_OPTIONS = %i[multivalue].freeze

    attr_reader :name

    def initialize(name, opts = {}, &block)
      @name = name.to_s
      @opts = opts
      @block = block

      validate_options!
    end

    def apply(permitted_param, scope)
      filter_value = parse_filter_value(permitted_param)
      block.call(filter_value, scope)
    end

    private

    attr_reader :opts, :block

    def parse_filter_value(permitted_param)
      return permitted_param unless opts[:multivalue]
      permitted_param.split(',')
    end

    def validate_options!
      invalid_option = opts.keys.find { |option| ALLOWED_OPTIONS.exclude? option }
      return true if invalid_option.nil?
      raise Errors::OptionNotAllowed, invalid_option
    end
  end
end
