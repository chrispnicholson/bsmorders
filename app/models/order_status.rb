class OrderStatus < ActiveRecord::Base
  attr_accessible :order_status_reason
  belongs_to :order
  belongs_to :status
  validates_associated :status
end
