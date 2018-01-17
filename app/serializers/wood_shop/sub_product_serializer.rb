module WoodShop
  class SubProductSerializer < Flexserializer::Base
    include WoodShop::Engine.routes.url_helpers

    default_attributes do
      define_attributes :id, :name, :sku
    end

    group(:product, :orders, :cart) do
      define_attributes :exist, :price, :text, :small_text, :path
    end

    group(:product) do
      define_attributes :exist, :price, :text, :small_text, :images, :title, :description, :keywords
    end

    group(:cart) do
      define_attributes :main_image_cart
    end

    group(:update_price) do
      define_attributes :price, :product_id, :vendor_id

      def price
        object.price or 0
      end
    end

    def name
      object&.name&.capitalize or ''
    end

    def price
      object.price&.to_price or 0
    end

    def path
      product_path(object.product)
    end

    def main_image_cart
      images = object.images
      images = object.product.images if images.empty?
      {
          image: (images.find_by(primary: true)&.image&.cart&.url or ''),
          alt:   (images.find_by(primary: true)&.alt or '')
      }
    end

    def images
      images  = object.images
      return ActiveModelSerializers::SerializableResource.new(object.product.images, define_options).serializable_hash if images.empty?
      ActiveModelSerializers::SerializableResource.new(images, define_options).serializable_hash
    end

    def categories
      ActiveModelSerializers::SerializableResource.new(object.categories, define_options).serializable_hash
    end
  end
end