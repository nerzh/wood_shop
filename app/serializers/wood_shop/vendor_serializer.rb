module WoodShop
  class VendorSerializer < Flexserializer::Base
    default_attributes do
      define_attributes :id, :name, :replace_if, :file_path, :col_sku, :col_name, :col_price
    end

    def file_path
      object.file.nil? ? nil : object.file.path
    end
  end
end