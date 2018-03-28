require 'action_controller'

module Resourcey
  class Config
    attr_accessor :default_paginator
    attr_accessor :controller_parent

    def initialize
      self.default_paginator = :paged
      self.controller_parent = 'action_controller/base'
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
