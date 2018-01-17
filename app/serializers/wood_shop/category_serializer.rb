module WoodShop
  class CategorySerializer < Flexserializer::Base
    include WoodShop::Engine.routes.url_helpers

    default_attributes do
      define_attributes :id, :name, :slug
    end

    group(:for_category_list) do
      define_attributes :groups, :prod_count, :path
    end

    group(:with_groups) do
      define_attributes :groups
    end

    group(:product) do
      define_attributes :catalogs
    end

    def name
      Unicode.capitalize(object.name)
    end

    def path
      category_path(instance_options[:catalog_slug], object.slug)
    end

    def groups
      ActiveModelSerializers::SerializableResource.new(object.groups, define_options).serializable_hash
    end
  end
end