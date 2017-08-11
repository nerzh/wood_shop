module WoodShop
  class Product < ApplicationRecord
    include ModelHelper

    belongs_to :brand, optional: true
    has_many :filter_values, through: :filters_products
    has_many :filters, through: :filter_values
    has_many :filters_products
    has_many :categories, through: :category_products
    has_many :category_products
    has_many :groups, through: :group_products
    has_many :group_products
    has_many :sub_products
    has_many :image_products
  end
end
