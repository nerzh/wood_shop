module WoodShop
  class ImageProductSerializer < Flexserializer::Base

    default_attributes do
      define_attributes :id, :primary, :alt
    end

    group(:product) {
      define_attributes :order, :big, :small, :cart
    }

    def big
      object.image&.big&.url or ''
    end

    def cart
      object.image&.cart&.url or ''
    end

    def small
      object.image&.small&.url or ''
    end
  end
end