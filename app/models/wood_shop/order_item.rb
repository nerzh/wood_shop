module WoodShop
  class OrderItem < ApplicationRecord
    belongs_to :order
  end
end
