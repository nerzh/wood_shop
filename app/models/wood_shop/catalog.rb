module WoodShop
  class Catalog < ApplicationRecord
    include ModelHelper

    belongs_to :shop
    has_many :categories
    has_many :filter_values, through: :filters_catalogs
    has_many :filters, through: :filter_values
    has_many :filters_catalogs
    has_many :products
  end
end
