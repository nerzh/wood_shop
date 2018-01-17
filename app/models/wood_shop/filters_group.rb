module WoodShop
  class FiltersGroup < ApplicationRecord
    belongs_to :group
    belongs_to :filter_value

    after_commit :change_filters_array

    private

    def change_filters_array
      obj = Group.find(self.group_id)
      obj.update_filters
    end
  end
end
