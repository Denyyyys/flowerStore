class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :flower
  validates :quantity, numericality: { greater_than: 0 }
end
