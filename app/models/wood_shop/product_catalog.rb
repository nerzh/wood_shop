module WoodShop
  class ProductCatalog < ApplicationRecord
    include ModelHelper

    belongs_to :product
    belongs_to :catalog

    after_commit :update_all_counters

    private

    def update_all_counters
      update_counters(WoodShop::Catalog.name.demodulize)
    end
  end
end
