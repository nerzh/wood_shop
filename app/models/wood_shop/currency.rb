module WoodShop
  class Currency < ApplicationRecord
    has_many :currency_vendors
    has_many :vendors, through: :currency_vendors

    def self.default_in_cent
      self.find_by(primary: true).value
    end
  end
end
