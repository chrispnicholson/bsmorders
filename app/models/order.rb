class Order < ActiveRecord::Base
  attr_accessible :ordered_at, :vat
  before_validation :ordered_at_cannot_be_in_the_past
  before_destroy :cannot_delete_order
  has_many :line_items
  has_one :order_status
  
  validates :vat, numericality: {greater_than_or_equal_to: 0.01, less_than_or_equal_to: 99.99}
  
  protected
  def cannot_delete_order
	return false
  end
  
  def ordered_at_cannot_be_in_the_past
    if self.ordered_at < Date.today
	  errors.add(:ordered_at, "can't be in the past")
	end
  end
end
