module WoodShop
  class ProductCategory < ApplicationRecord
    include ModelHelper

    belongs_to :product
    belongs_to :category

    after_commit :update_all_counters

    private

    def update_all_counters
      update_counters(WoodShop::Category.name.demodulize)
    end
  end
end
