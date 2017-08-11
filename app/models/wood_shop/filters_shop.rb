module WoodShop
  class FiltersShop < ApplicationRecord
    belongs_to :shop
    belongs_to :filter_value

    after_save :change_filters_array

    private

    def change_filters_array
      obj = Shop.find(self.shop_id)
      obj.update_filters
    end
  end
end
