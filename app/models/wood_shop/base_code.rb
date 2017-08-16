module WoodShop
  class BaseCode < ApplicationRecord
    belongs_to :sub_product
    belongs_to :vendor
    has_many :currency_vendors, through: :vendor
  end
end
