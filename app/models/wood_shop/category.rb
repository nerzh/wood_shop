module WoodShop
  class Category < ApplicationRecord
    include ModelHelper

    belongs_to :catalog, optional: true
    has_many :groups
    has_many :filter_values, through: :filters_categories
    has_many :filters, through: :filter_values
    has_many :filters_categories
    has_many :products, through: :category_products
    has_many :category_products
  end
end
