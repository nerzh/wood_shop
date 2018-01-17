module WoodShop
  class FiltersCategory < ApplicationRecord
    belongs_to :category
    belongs_to :filter_value

    after_commit :change_filters_array

    private

    def change_filters_array
      obj = Category.find(self.category_id)
      obj.update_filters
    end
  end
end
