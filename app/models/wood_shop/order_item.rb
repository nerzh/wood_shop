module WoodShop
  class OrderItem < ApplicationRecord
    belongs_to :order
    before_create :check_item
    after_commit  :update_order

    def total_price
      self.price&.to_price * self.quantity
    end

    def check_item
      price = WoodShop::SubProduct.find(self.sub_product_id).price
      self.price = price
    end

    def update_order
      order = self.order
      total_price = 0
      order.order_items.each { |item| total_price += item.total_price || 0 }
      delivery_price = order.delivery.price&.to_price || 0
      payment_price  = order.payment.price&.to_price || 0
      order.total_price = (total_price + delivery_price + payment_price).to_cent
      order.save if order.changed?
    end
  end
end
