module WoodShop
  class PaymentSerializer < Flexserializer::Base

    default_attributes do
      define_attributes :id, :name, :small_description, :payment_type
    end
  end
end