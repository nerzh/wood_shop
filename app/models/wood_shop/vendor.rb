module WoodShop
  class Vendor < ApplicationRecord
    has_many :base_codes
    has_many :base_prod_rejects
    has_many :sub_products
    has_many :base_prod_news, class_name: BaseProdNew

    has_many :currency_vendors
    has_many :currencies, through: :currency_vendors
  end
end
