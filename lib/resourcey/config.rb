module Resourcey
  class Config
    attr_accessor :foo

    def initialize
      self.foo = 'foo'
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
