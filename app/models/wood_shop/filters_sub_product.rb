module WoodShop
  class FiltersSubProduct < ApplicationRecord
    belongs_to :sub_product
    belongs_to :filter_value

    after_commit :change_filters_array

    private

    def change_filters_array
      obj = SubProduct.find(self.sub_product_id)
      obj.update_filters
    end
  end
end
