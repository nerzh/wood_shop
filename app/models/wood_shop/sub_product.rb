module WoodShop
  class SubProduct < ApplicationRecord
    after_save :update_product

    include FiltersHelper

    belongs_to :product
    belongs_to :vendor, optional: true
    belongs_to :brand, optional: true
    has_many :filter_values, through: :filters_sub_products
    has_many :filters, through: :filter_values
    has_many :filters_sub_products
    has_many :image_sub_products

    private

    def update_product
      prod = self.product
      if prod.sub_products.map { |sp| sp.exist }.include?(false)
        prod.exist = false
      else
        prod.exist = true
      end
      prod.save
    end
  end
end
