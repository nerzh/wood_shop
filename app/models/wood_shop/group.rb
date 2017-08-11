module WoodShop
  class Group < ApplicationRecord
    include ModelHelper

    belongs_to :category, optional: true
    has_many :filter_values, through: :filters_groups
    has_many :filters, through: :filter_values
    has_many :filters_groups
    has_many :products, through: :group_products
    has_many :group_products
  end
end
