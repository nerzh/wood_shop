module WoodShop
  class CatalogSerializer < Flexserializer::Base
    include WoodShop::Engine.routes.url_helpers

    default_attributes do
      define_attributes :id, :name, :slug
    end

    group(:for_category_list) do
      define_attributes :categories, :prod_count, :path, :active
    end

    group(:with_categories) do
      define_attributes :categories
    end

    def name
      Unicode.capitalize(object.name)
    end

    def path
      catalog_path(object.slug)
    end

    def active
      false
    end

    def categories
      ActiveModelSerializers::SerializableResource.new(object.categories, define_options.merge({catalog_slug: object.slug})).serializable_hash
    end
  end
end