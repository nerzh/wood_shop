module WoodShop
  class ImageSubProduct < ApplicationRecord
    belongs_to :sub_product

    mount_uploader :image, ImageSubProductUploader
  end
end
