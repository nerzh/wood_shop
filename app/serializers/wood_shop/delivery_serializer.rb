module WoodShop
  class DeliverySerializer < Flexserializer::Base

    default_attributes do
      define_attributes :id, :name, :small_description, :price, :delivery_type
    end

    def price
      object.price&.to_price
    end

    group(:order) {
      define_has_many :payments
    }
  end
end