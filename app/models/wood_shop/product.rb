module WoodShop
  class Product < ApplicationRecord
    before_validation :set_url_and_id # validation - потому что потом уже friendly id не отработает

    extend FriendlyId
    friendly_id :url, use: [:slugged, :finders, :history]
    include ModelHelper
    include FiltersHelper

    belongs_to :brand, optional: true
    # has_many :base_codes, dependent: :destroy
    has_many :filters_products
    # has_many :filter_values, through: :filters_products
    # has_many :filters,       through: :filter_values

    has_many :product_categories, dependent: :destroy
    has_many :categories, through: :product_categories

    has_many :product_catalogs, dependent: :destroy
    has_many :catalogs, through: :product_catalogs

    has_many :product_groups, dependent: :destroy
    has_many :groups,   through: :product_groups

    has_many :sub_products, dependent: :destroy
    has_many :filters_sub_products, through: :sub_products
    has_many :filter_values, through: :filters_sub_products
    has_many :filters,       through: :filter_values

    has_many :image_products, dependent: :destroy
    has_many :images, class_name: 'ImageProduct'

    # FOR ActiveAdmin FILTERS
    ransacker :catalog,
              formatter: proc { |ids|
                matches = Product.joins(:product_catalogs).where(wood_shop_product_catalogs: { catalog_id: Array.wrap(ids) }).map(&:id)
                matches.any? ? matches : nil
              } do |parent|
      parent.table[:id]
    end

    ransacker :category,
              formatter: proc { |ids|
                matches = Product.joins(:product_categories).where(wood_shop_product_categories: { category_id: Array.wrap(ids) }).map(&:id)
                matches.any? ? matches : nil
              } do |parent|
      parent.table[:id]
    end

    ransacker :group,
              formatter: proc { |ids|
                matches = Product.joins(:product_groups).where(wood_shop_product_groups: { group_id: Array.wrap(ids) }).map(&:id)
                matches.any? ? matches : nil
              } do |parent|
      parent.table[:id]
    end

    private

    def set_url_and_id
      return if self.id
      self.id  = self.class.connection.select_value("Select nextval('#{self.class.table_name}_id_seq')")
      self.url = self.name.to_s + "_#{self.id}"
    end
  end
end
