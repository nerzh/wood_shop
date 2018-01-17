module WoodShop
  class FiltersCatalog < ApplicationRecord
    belongs_to :catalog
    belongs_to :filter_value

    after_commit :change_filters_array

    private

    def change_filters_array
      obj = Catalog.find(self.catalog_id)
      obj.update_filters
    end
  end
end
