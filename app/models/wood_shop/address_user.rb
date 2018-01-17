module WoodShop
  class AddressUser < ApplicationRecord
    belongs_to :user
    belongs_to :city,   optional: true
    belongs_to :area,   optional: true
    belongs_to :street, optional: true
    # def area
    #   return Area.find(self.area_id)&.description if self.area_id
    #   nil
    # end
    #
    # def city
    #   return City.find(self.city_id)&.description_ru if self.city_id
    #   nil
    # end
    #
    # def street
    #   return Street.find(self.street_id)&.description if self.street_id
    #   nil
    # end
  end
end
