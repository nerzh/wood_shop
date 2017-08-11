module WoodShop
  class Settlement < ApplicationRecord
    belongs_to :area, optional: true
  end
end
