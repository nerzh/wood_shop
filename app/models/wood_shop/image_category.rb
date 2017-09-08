module WoodShop
  class ImageCategory < ApplicationRecord
    belongs_to :category

    mount_uploader :image, ImageCategoryUploader
  end
end
