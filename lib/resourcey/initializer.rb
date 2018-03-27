module Resourcey
  class Initializer < Rails::Railtie
    initializer 'resourcey.load_controller', after: :load_config_initializers do
      require 'resourcey/controller'
    end
  end
end
