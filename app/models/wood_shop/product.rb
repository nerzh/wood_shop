module WoodShop
  class Product < ApplicationRecord
    before_validation :generate_url

    extend FriendlyId
    friendly_id :url, use: [:slugged, :finders, :history]
    include ModelHelper
    include FiltersHelper

    belongs_to :brand, optional: true
    has_many :filters_products
    has_many :filter_values, through: :filters_products
    has_many :filters,       through: :filter_values
    has_many :category_products
    has_many :categories, through: :category_products
    has_many :groups,     through: :category_products
    has_many :sub_products
    has_many :image_products

    private

    def generate_url
      return if self.name == '' || self.name == nil
      self.url = self.name
    end
  end
end
