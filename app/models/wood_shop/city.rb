module WoodShop
  class City < ApplicationRecord
    belongs_to              :area
    has_and_belongs_to_many :streets
    has_many                :users, class_name: 'WoodShop::AddressUser'
    has_many                :address_users
    has_many                :address_orders
  end
end
