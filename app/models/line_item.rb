class LineItem < ActiveRecord::Base
  attr_accessible :quantity, :order_id, :product_id
  belongs_to :order
  belongs_to :product
  
  validates :quantity, numericality: {greater_than: 0}
end
