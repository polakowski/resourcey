module Resourcey
  class FixturesInitializer < Rails::Railtie
    initializer 'resourcey.load_test_fixtures', after: 'resourcey.load_controller' do
      require 'fixtures'
    end
  end
end
