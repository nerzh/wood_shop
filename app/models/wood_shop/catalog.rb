module WoodShop
  class Catalog < ApplicationRecord
    before_validation :generate_url

    extend FriendlyId
    friendly_id :url, use: [:slugged, :finders, :history]
    include ModelHelper
    include FiltersHelper

    belongs_to :shop
    has_many :categories
    has_many :products
    has_many :filters_catalogs
    has_many :filter_values, through: :filters_catalogs
    has_many :filters,       through: :filter_values

    private

    def generate_url
      return if self.name == '' || self.name == nil
      self.url = self.name
    end
  end
end
