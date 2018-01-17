module WoodShop
  class AreaSerializer < Flexserializer::Base

    default_attributes do
      define_attributes :id, :description_ru
    end

    group(:orders) {
      define_has_many :cities
    }
  end
end