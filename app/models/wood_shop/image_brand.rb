module WoodShop
  class ImageBrand < ApplicationRecord
    belongs_to :brand

    mount_uploader :image, ImageBrandUploader
  end
end
