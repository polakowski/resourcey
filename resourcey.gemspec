Gem::Specification.new do |s|
  s.name        = 'resourcey'
  s.version     = '0.0.1'
  s.date        = '2018-01-16'
  s.summary     = 'resourcey'
  s.description = 'Lightweight utility to create simple JSON Apis'
  s.authors     = ['polakowski']
  s.email       = 'marek.polakowski@gmail.com'
  s.files       = Dir.glob('{bin,lib}/**/*') + %w(README.md)
  s.homepage    = 'http://rubygems.org/gems/resourcey'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.4'

  s.add_development_dependency 'bundler', '~> 1.5'
  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'combustion', '~> 0.8.0'
  s.add_dependency 'activerecord', '>= 4'
  s.add_dependency 'railties', '>= 4'
  s.add_dependency 'active_model_serializers', '~> 0.10.6'
end