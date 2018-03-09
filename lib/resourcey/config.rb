module Resourcey
  class Config
    attr_accessor :default_paginator

    def initialize
      self.default_paginator = :paged
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
