module WoodShop
  class ImageUser < ApplicationRecord
    belongs_to :user
    after_create :update_primary

    mount_uploader :image, ImageUserUploader

    def update_primary
      if self.primary == true
        self.user.images.each do |image_user|
          image_user.update!(primary: false) unless image_user.id == self.id
        end
      end
    end
  end
end
