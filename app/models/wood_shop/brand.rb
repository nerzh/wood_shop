module WoodShop
  class Brand < ApplicationRecord
    before_validation :generate_url

    extend FriendlyId
    friendly_id :url, use: [:slugged, :finders, :history]
    include ModelHelper

    has_many :products
    has_many :sub_products

    private

    def generate_url
      return if self.name == '' || self.name == nil
      self.url = self.name
    end
  end
end
