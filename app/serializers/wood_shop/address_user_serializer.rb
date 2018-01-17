module WoodShop
  class AddressUserSerializer < Flexserializer::Base
    include WoodShop::Engine.routes.url_helpers

    default_attributes do
      define_attributes :id, :area, :city, :street, :first_name, :last_name, :zip, :phone
    end

    group(:orders) do
      define_attributes :area_id, :city_id, :street_id
    end

    def area
      object.area&.description_ru
    end

    def city
      object.city&.description_ru
    end

    def street
      object.street&.description_ru
    end
  end
end