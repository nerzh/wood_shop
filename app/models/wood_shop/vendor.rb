module WoodShop
  class Vendor < ApplicationRecord

    mount_uploader :file, VendorUploader

    enum replace_if: { if_more: 'if_more', if_less: 'if_less', replace: 'replace' }

    has_many :base_codes
    has_many :base_prod_rejects
    has_many :sub_products
    has_many :base_prod_news, class_name: 'WoodShop::BaseProdNew'

    has_many :currency_vendors
    has_many :currencies, through: :currency_vendors
  end
end
