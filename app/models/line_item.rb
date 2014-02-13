class LineItem < ActiveRecord::Base
  attr_accessible :quantity, :order_id, :product_id
  belongs_to :order
  has_one :product
  
  validates :quantity, numericality: {greater_than: 0}
end
