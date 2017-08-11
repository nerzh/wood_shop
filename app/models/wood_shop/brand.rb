module WoodShop
  class Brand < ApplicationRecord
    has_many :products
    has_many :sub_products
  end
end
