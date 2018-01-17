module WoodShop
  class OrderSerializer < Flexserializer::Base
    include WoodShop::Engine.routes.url_helpers

    default_attributes do
      define_attributes :id, :total_price, :aasm_state, :created_at
    end

    def total_price
      object.total_price&.to_price or 0
    end

    group(:orders) {
      define_attributes :order_items
    }

    def address_user
      ActiveModelSerializers::SerializableResource.new(object.order_items, define_options).serializable_hash
    end
  end
end