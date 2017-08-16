module WoodShop
  class FilterValue < ApplicationRecord
    belongs_to :filter
    has_many :filters_shops
    has_many :shops, through: :filters_shops
    has_many :filters_catalogs
    has_many :catalogs, through: :filters_catalogs
    has_many :filters_categories
    has_many :categories, through: :filters_categories
    has_many :filters_groups
    has_many :groups, through: :filters_groups
    has_many :filters_products
    has_many :products, through: :filters_products
    has_many :filters_sub_products
    has_many :sub_products, through: :filters_sub_products
  end
end
