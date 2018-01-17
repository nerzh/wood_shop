module WoodShop
  class OrderItemSerializer < Flexserializer::Base
    include WoodShop::Engine.routes.url_helpers

    default_attributes do
      define_attributes :id, :quantity, :product
    end

    def products
      ActiveModelSerializers::SerializableResource.new(object.product, define_options).serializable_hash
    end
  end
end