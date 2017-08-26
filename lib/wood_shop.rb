require "wood_shop/engine"
require 'wood_shop/my_route_app'

def self.self_require(name)
  begin
    require name
  rescue LoadError => ex
    p ex
  end
end

Gem.loaded_specs['wood_shop'].dependencies.each do |d|
  self_require d.name
end

module WoodShop
  # Your code goes here...
end
