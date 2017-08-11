module WoodShop
  class FiltersProduct < ApplicationRecord
    belongs_to :product
    belongs_to :filter_value

    after_save :change_filters_array

    private

    def change_filters_array
      obj = Product.find(self.product_id)
      obj.update_filters
    end
  end
end
