module WoodShop
  class Category < ApplicationRecord
    before_validation :generate_url

    extend FriendlyId
    friendly_id :url, use: [:slugged, :finders, :history]
    include ModelHelper
    include FiltersHelper

    belongs_to :catalog, optional: true
    has_many :filters_categories
    has_many :filter_values, through: :filters_categories
    has_many :filters, through: :filter_values
    has_many :category_products
    has_many :products, through: :category_products
    has_many :groups,   through: :category_products
    has_many :image_categories
    has_many :images,   class_name: 'ImageCategory'

    private

    def generate_url
      return if self.name == '' || self.name == nil
      self.url = self.name + (self.catalog ? ('-' + self.catalog.name) : '')
    end
  end
end
