class LineItem < ActiveRecord::Base
  attr_accessible :quantity, :order_id, :product_id
  belongs_to :order
  belongs_to :product
  
  before_update :check_order_status_before_update
  validates :quantity, numericality: {greater_than: 0}
  
  protected
  def check_order_status_before_update
    current_order_status_type = order.current_order_status.status.status_type
	if current_order_status_type == "DRAFT"
	  return true
	else
	  return false
	end
  end
end
