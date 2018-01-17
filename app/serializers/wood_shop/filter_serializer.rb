module WoodShop
  class FilterSerializer < Flexserializer::Base

    default_attributes do
      define_attributes :id, :name, :numeric, :order
    end

    group(:catalog) do
      define_attributes :filter_values, :min, :max, :min_start, :max_start
    end

    def name
      Unicode.capitalize(object.name)
    end

    def min
      min_max[:min]
    end

    def max
      min_max[:max]
    end

    def min_start
      @min_start
    end

    def max_start
      @max_start
    end

    def min_max
      return {min: nil, max: nil} if !object.numeric
      max_min = define_options[:prods].select('min(wood_shop_filter_values.num_value) as min, max(wood_shop_filter_values.num_value) as max')
      { min: max_min[0].min, max: max_min[0].max }
    end

    def filter_values
      f_values = object.filter_values.joins(:products).where('wood_shop_products.id' => define_options[:prods]).group(:id)
      if object.numeric
        max_min    = f_values.select('min(wood_shop_filter_values.num_value) as min, max(wood_shop_filter_values.num_value) as max')
        @min_start = max_min[0].min
        @max_start = max_min[0].max
      end
      ActiveModelSerializers::SerializableResource.new(f_values, define_options).serializable_hash
    end
  end
end