module WoodShop
  class CurrencyVendor < ApplicationRecord
    belongs_to :vendor
    belongs_to :currency
  end
end
