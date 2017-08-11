module WoodShop
  class BaseProdReject < ApplicationRecord
    belongs_to :product
    belongs_to :vendor
  end
end
