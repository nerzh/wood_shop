module WoodShop
  class ProductGroup < ApplicationRecord
    include ModelHelper

    belongs_to :product
    belongs_to :group

    after_commit :update_all_counters

    private

    def update_all_counters
      update_counters(WoodShop::Group.name.demodulize)
    end
  end
end
