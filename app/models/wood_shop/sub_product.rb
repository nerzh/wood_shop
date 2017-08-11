module WoodShop
  class SubProduct < ApplicationRecord
    include ModelHelper

    belongs_to :product
    belongs_to :vendor, optional: true
    belongs_to :brand, optional: true
    has_many :filter_values, through: :filters_sub_products
    has_many :filters, through: :filter_values
    has_many :filters_sub_products
    has_many :image_sub_products
  end
end
