module WoodShop
  class ImageProduct < ApplicationRecord
    belongs_to :product

    mount_uploader :image, ImageProductUploader
  end
end
