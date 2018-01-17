module WoodShop
  class GroupSerializer < Flexserializer::Base
    default_attributes do
      define_attributes :id, :name
    end

    group(:with_prod_count) do
      define_attribute :prod_count
    end

    group(:for_category_list) do
      define_attribute :prod_count
    end

    group(:catalog) do
      define_attribute :str_value
    end

    def str_value
      object.name
    end
  end
end