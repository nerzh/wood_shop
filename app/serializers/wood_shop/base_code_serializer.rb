module WoodShop
  class BaseCodeSerializer < Flexserializer::Base
    default_attributes do
      define_attributes :id, :sub_product_id, :vendor_id, :vendor_sku, :product_sku
    end
  end
end