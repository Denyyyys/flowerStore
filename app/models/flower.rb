class Flower < ApplicationRecord
  has_one_attached :image
  has_many :order_items
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :image, presence: true

end