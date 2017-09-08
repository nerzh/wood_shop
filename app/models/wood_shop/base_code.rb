module WoodShop
  class BaseCode < ApplicationRecord
    belongs_to :product, optional: true
    belongs_to :sub_product, optional: true
    belongs_to :vendor
    has_many :currency_vendors, through: :vendor
  end
end
