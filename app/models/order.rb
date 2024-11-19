class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum order_status: {
    pending: 'pending',
    confirmed: 'confirmed',
    cancelled: 'cancelled',
    on_the_way: 'on_the_way',
    delivered: 'delivered',
    returned: 'returned',
    failed: 'failed'
  }

  validates :order_status, presence: true, inclusion: { in: order_statuses.keys }

end
