module WoodShop
  class FilterValueSerializer < Flexserializer::Base
    default_attributes do
      define_attributes :id, :str_value, :num_value
    end

    def name
      Unicode.capitalize(object.name)
    end
  end
end