module WoodShop
  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_one :address_user, dependent: :destroy
    has_one :address_order, dependent: :destroy

    has_many :orders, dependent: :destroy
    has_many :image_users, dependent: :destroy
    has_many :images, class_name: 'ImageUser'
  end
end
