class OrderStatus < ActiveRecord::Base
  attr_accessible :order_id, :status_id
  belongs_to :order
  has_many :statuses
  validates_associated :statuses
end
