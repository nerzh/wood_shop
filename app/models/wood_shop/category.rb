module WoodShop
  class Category < ApplicationRecord
    before_validation :set_url_and_id # validation - потому что потом уже friendly id не отработает

    extend FriendlyId
    friendly_id :url, use: [:slugged, :finders, :history]
    include ModelHelper
    include FiltersHelper

    has_many :filters_categories, dependent: :destroy
    has_many :filter_values, through: :filters_categories
    has_many :filters, through: :filter_values

    has_many :product_categories, dependent: :destroy
    has_many :products, through: :product_categories
    has_many :filters_products, through: :products
    has_many :prod_filter_values, through: :filters_products, source: :filter_value
    has_many :prod_filters, through: :prod_filter_values,     source: :filter

    has_many :catalog_categories, dependent: :destroy
    has_many :catalogs, through: :catalog_categories

    has_many :category_groups, dependent: :destroy
    has_many :groups, through: :category_groups

    has_many :image_categories, dependent: :destroy
    has_many :images, class_name: 'ImageCategory'

    private

    def set_url_and_id
      return if self.id
      self.id  = self.class.connection.select_value("Select nextval('#{self.class.table_name}_id_seq')")
      self.url = self.name.to_s + "_#{self.id}"
    end
  end
end
