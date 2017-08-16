$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "wood_shop/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "wood_shop"
  s.version     = WoodShop::VERSION
  s.authors     = ["woodcrust"]
  s.email       = ["emptystamp@gmail.com"]
  s.homepage    = "https://github.com/woodcrust/wood_shop"
  s.summary     = "Nothing interesting"
  s.description = "This is WoodShop."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails",                    '~> 5.1.2'
  s.add_dependency 'slim_form_object',         '~> 1.0.0'
  s.add_dependency 'aasm',                     '~> 4.12.1'
  s.add_dependency 'wicked',                   '~> 1.3', '>= 1.3.0'
  s.add_dependency "haml-rails",               '~> 1.0.0'
  s.add_dependency 'sass-rails',               '~> 5.0.0'
  s.add_dependency 'font-awesome-sass',        '~> 4.7.0'
  s.add_dependency 'cancancan',                '~> 2.0.0'
  s.add_dependency 'devise',                   '~> 4.3.0'
  s.add_dependency 'carrierwave',              '~> 1.1.0'
  s.add_dependency 'mini_magick',              '~> 4.8.0'
  s.add_dependency 'flexbox-rails',            '~> 1.0.1'
  s.add_dependency 'fast_xls_to_hash',         '~> 0.2.0'
  s.add_dependency 'bower-rails',              '~> 0.11.0'
  s.add_dependency 'active_model_serializers', '~> 0.10.6'
  s.add_dependency 'angular-rails-templates',  '~> 1.0.2'
  s.add_dependency 'activeadmin',              '~> 1.1.0'
  s.add_dependency 'jquery-ui-sass-rails',     '~> 4.0.3.0'
  s.add_dependency 'unicode',                  '~> 0.4.4.4'
  s.add_dependency 'versionist',               '~> 1.6.0'
  #Base
  s.add_dependency "activerecord-import",      '~> 0.19.1'
  s.add_dependency 'friendly_id',              '~> 5.2.1'
  s.add_dependency 'babosa',                   '~> 1.0.2'
  s.add_dependency 'kaminari',                 '~> 1.0.1'
  s.add_dependency 'pg',                       '~> 0.21.0'

  s.add_development_dependency "sqlite3"
end