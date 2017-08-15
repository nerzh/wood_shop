module WoodShop
  class Group < ApplicationRecord
  include ModelHelper

    has_many :filter_values, through: :filters_groups
    has_many :filters, through: :filter_values
    has_many :filters_groups
    has_many :products, through: :category_products
    has_many :categories, through: :category_products
    has_many :category_products
  end
end
