module WoodShop
  module FiltersHelper
    def update_filters
      self.filterids       = self.filters.pluck(:id)
      self.filter_valueids = self.filter_values.pluck(:id)
      self.save
    end
  end
end