module WoodShop
  class Street < ApplicationRecord
    has_and_belongs_to_many :cities
    has_many                :address_users
    has_many                :address_orders
  end
end
