class LineItem < ActiveRecord::Base
  attr_accessible :quantity
  belongs_to :order
  has_one :product
  
  validates :quantity, numericality: {greater_than: 0}, default: 1
end
