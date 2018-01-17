module WoodShop
  class ProductSerializer < Flexserializer::Base
    include WoodShop::Engine.routes.url_helpers

    default_attributes do
      define_attributes :id, :name, :slug, :sku_sub_products
    end

    group(:product) {
      define_attributes :complex, :exist, :min_price, :max_price, :text, :small_text, :title, :description, :keywords
      define_attributes :categories, :images, :random, :sub_products
      define_has_many :catalogs
      define_has_many :groups
    }

    group(:catalog, :orders) do
      define_attributes :main_image_cart, :min_price, :max_price, :path, :total_pages, :images, :small_text
    end

    def name
      object.name&.capitalize
    end

    def min_price
      object.min_price&.to_price or 0
    end

    def max_price
      object.max_price&.to_price or 0
    end

    def path
      product_path(object)
    end

    def total_pages
      instance_options[:pages]
    end

    def main_image_cart
      {
        image: (object.images.find_by(primary: true)&.image&.cart&.url or ''),
        alt:   (object.images.find_by(primary: true)&.alt or '')
      }
    end

    def sub_products
      ActiveModelSerializers::SerializableResource.new(WoodShop::SubProduct.where(id: object.sub_productids), define_options).serializable_hash
    end

    def random
      arr_prodids = object.categories.first.products.pluck(:id)
      arr_rand_prodids = []
      12.times { |n| arr_rand_prodids << arr_prodids[rand(arr_prodids.size)] }
      prods   = object.categories.first.products.where(id: arr_rand_prodids)
      ActiveModelSerializers::SerializableResource.new(prods, define_options.merge({group: :catalog})).serializable_hash
    end

    def images
      ActiveModelSerializers::SerializableResource.new(object.images, define_options).serializable_hash
    end

    def categories
      ActiveModelSerializers::SerializableResource.new(object.categories, define_options).serializable_hash
    end
  end
end