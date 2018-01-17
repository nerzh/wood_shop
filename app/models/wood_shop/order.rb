module WoodShop
  class Order < ApplicationRecord
    include AASM

    has_many :order_items, dependent: :destroy
    has_one  :address_order, dependent: :destroy
    belongs_to :user, optional: true
    belongs_to :delivery, optional: true
    belongs_to :payment, optional: true

    enum aasm_state: { process: 'в обработке', moderate: 'доставка', success: 'выполнен' }

    aasm do
      state :process, initial: true
      state :moderate
      state :success

      event :process do
        transitions from: [:moderate, :success], to: :failure
      end

      event :moderate do
        transitions from: [:process, :success], to: :moderate
      end

      event :success do
        transitions from: [:process, :moderate], to: :success
      end
    end
  end
end
