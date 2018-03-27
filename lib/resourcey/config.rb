module Resourcey
  class Config
    attr_accessor :default_paginator
    attr_reader :controller_parent

    def initialize
      self.default_paginator = :paged
      self.controller_parent = ActionController::Base
    end

    def controller_parent=(value)
      return @controller_parent = value if value.class == Class

      begin
        @controller_parent = value.to_s.constantize
      rescue
        raise Errors::RuntimeError.new("#{value} is not a valid class name")
      end
    end
  end

  class << self
    attr_accessor :config
  end

  @config ||= Config.new

  def self.configure
    yield @config
  end
end
