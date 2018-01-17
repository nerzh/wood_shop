module WoodShop
  module FiltersHelper
    def update_filters
      self.filterids       = (self.filterids + self.filters.pluck(:id)).uniq
      self.filter_valueids = (self.filter_valueids + self.filter_values.pluck(:id)).uniq
      self.save if self.change?
    end
  end
end