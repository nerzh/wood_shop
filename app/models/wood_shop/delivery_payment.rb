module WoodShop
  class DeliveryPayment < ApplicationRecord
    belongs_to :delivery
    belongs_to :payment
  end
end
