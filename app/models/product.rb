class Product < ActiveRecord::Base
  attr_accessible :name, :price 
  validates :name, presence: true, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  has_many :orders, through: :line_items, :dependent => :restrict_with_error
  
end
