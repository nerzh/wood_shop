module WoodShop
  class Filter < ApplicationRecord
    has_many :filter_values, dependent: :destroy
    has_many :products,     through: :filter_values
    has_many :sub_products, through: :filter_values
  end
end
