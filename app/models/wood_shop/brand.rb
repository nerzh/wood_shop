module WoodShop
  class Brand < ApplicationRecord
    before_validation :set_url_and_id # validation - потому что потом уже friendly id не отработает

    extend FriendlyId
    friendly_id :url, use: [:slugged, :finders, :history]
    include ModelHelper

    has_many :products, dependent: :destroy
    has_many :sub_products
    has_many :image_brands, dependent: :destroy
    has_many :images, class_name: 'ImageBrand'

    private

    def set_url_and_id
      return if self.id
      self.id  = self.class.connection.select_value("Select nextval('#{self.class.table_name}_id_seq')")
      self.url = self.name.to_s + "_#{self.id}"
    end
  end
end
