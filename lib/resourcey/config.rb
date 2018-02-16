module Resourcey
  class Config
    attr_reader :controller_parent

    def initialize
      self.controller_parent = nil
    end

    attr_writer :controller_parent

    @@config ||= Config.new

    class << self
      attr_accessor :config

      def configure
        yield @@config
      end
    end
  end
end
