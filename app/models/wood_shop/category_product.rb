module WoodShop
  class CategoryProduct < ApplicationRecord
    belongs_to :product
    belongs_to :category
    belongs_to :group, optional: true

    after_save :update_product

    private

    def update_product
      return unless prod = self.product
      prod.update(categoryids: prod.categories.pluck(:id))
      prod.update(groupids: prod.groups.pluck(:id))
    end
  end
end
