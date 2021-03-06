class Product < ActiveRecord::Base
  attr_accessible :name, :price 
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0.01}
  has_many :line_items
  has_many :orders, through: :line_items, :dependent => :restrict
  
end
