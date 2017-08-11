module WoodShop
  class Area < ApplicationRecord
    has_many :cities
    has_many :settlements
    has_many :address_users
    has_many :address_orders
  end
end
