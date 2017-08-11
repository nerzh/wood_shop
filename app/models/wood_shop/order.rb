module WoodShop
  class Order < ApplicationRecord
    has_many :order_items
    has_one  :address_order
  end
end
