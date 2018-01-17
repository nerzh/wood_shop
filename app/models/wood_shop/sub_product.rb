module WoodShop
  class SubProduct < ApplicationRecord
    after_commit :update_product

    include FiltersHelper

    belongs_to :product
    belongs_to :vendor, optional: true
    belongs_to :brand,  optional: true
    has_many :base_codes, dependent: :destroy
    has_many :filters_sub_products
    has_many :filter_values, through: :filters_sub_products
    has_many :filters,       through: :filter_values
    has_many :image_sub_products, dependent: :destroy
    has_many :images, class_name: 'ImageSubProduct'

    # FOR ActiveAdmin FILTERS
    ransacker :product,
              formatter: proc { |id|
                SubProduct.find_by(product_id: id)&.id
              } do |parent|
      parent.table[:id]
    end

    private

    def update_product
      prod = self.product
      # change amount ids of sub_products
      prod.sub_productids   = prod.sub_products.pluck(:id)
      # change amount sku of sub_products
      prod.sku_sub_products = prod.sub_products.pluck(:sku)
      # change complex status of product
      prod.complex = prod.sub_productids.size > 1
      #max min price
      min_max_data = prod.sub_products.select('min(wood_shop_sub_products.price) as min, max(wood_shop_sub_products.price) as max')
      min = min_max_data[0]&.send(:[], 'min')
      max = min_max_data[0]&.send(:[], 'max')
      prod.assign_attributes({min_price: min, max_price: max})
      # change exist of product
      if prod.sub_products.map { |sp| sp.exist }.include?(false)
        prod.exist = false
      else
        prod.exist = true
      end
      prod.save if prod.changed?
    end
  end
end