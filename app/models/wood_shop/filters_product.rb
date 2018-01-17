module WoodShop
  class FiltersProduct < ApplicationRecord
    belongs_to :product
    belongs_to :filter_value

    after_commit :change_filters_array

    private

    def change_filters_array
      # return unless obj = self.product
      # obj.update_filters
    end
  end
end
