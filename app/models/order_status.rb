class OrderStatus < ActiveRecord::Base
  attr_accessible :order_id, :status_id
  belongs_to :order
  has_many :statuses
end
