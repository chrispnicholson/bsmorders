class Order < ActiveRecord::Base
  attr_accessible :ordered_at, :vat
  before_destroy :cannot_delete_order
  has_many :line_items
  has_one :order_status
  
  validates :vat, numericality: {greater_than_or_equal_to: 0.01, less_than_or_equal_to: 99.99}
  validate :ordered_at_cannot_be_in_the_past
  
  protected
  def ordered_at_cannot_be_in_the_past
    if !ordered_at.blank? and ordered_at < Time.now
      errors.add(:ordered_at, "can't be in the past")
    end
  end

  def cannot_delete_order
	return false
  end
  

end
