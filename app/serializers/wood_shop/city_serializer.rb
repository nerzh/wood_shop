module WoodShop
  class CitySerializer < Flexserializer::Base

    default_attributes do
      define_attributes :id, :description_ru, :area_id
    end
  end
end