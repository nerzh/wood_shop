module WoodShop
  class Group < ApplicationRecord
    include ModelHelper
    has_many :filters_groups, dependent: :destroy
    has_many :filter_values, through: :filters_groups
    has_many :filters,       through: :filter_values

    has_many :product_groups, dependent: :destroy
    has_many :products, through: :product_groups

    has_many :category_groups, dependent: :destroy
    has_many :categories, through: :category_groups
  end
end
