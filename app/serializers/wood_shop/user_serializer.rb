module WoodShop
  class UserSerializer < Flexserializer::Base
    include WoodShop::Engine.routes.url_helpers

    default_attributes do
      define_attributes :id, :email
    end

    group(:profile, :orders, :address) {
      define_attributes :image_sm, :image_md, :image_lg, :address_user, :created_at
    }

    group(:orders) {
      define_attribute :orders
    }

    def image_lg
      object.images.find_by(primary: true)&.image&.lg&.url or ActionController::Base.helpers.image_path('images/user/no_avatar_lg.png')
    end

    def image_md
      object.images.find_by(primary: true)&.image&.md&.url or ActionController::Base.helpers.image_path('images/user/no_avatar_md.png')
    end

    def image_sm
      object.images.find_by(primary: true)&.image&.sm&.url or ActionController::Base.helpers.image_path('images/user/no_avatar_sm.png')
    end

    def orders
      ActiveModelSerializers::SerializableResource.new(object.orders, define_options).serializable_hash
    end

    def address_user
      ActiveModelSerializers::SerializableResource.new(object.address_user, define_options).serializable_hash
    end
  end
end