require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  fixtures :line_items, :orders, :products
  
  test "line item needs to have a quantity more than zero" do
	line_item = LineItem.new(order_id: 1, product_id: 1, quantity: 0)
	assert line_item.invalid?
	assert line_item.errors[:quantity].any?
	
	line_item2 = LineItem.new(order_id: 1, product_id: 1, quantity: -1)
	assert line_item2.invalid?
	assert line_item.errors[:quantity].any?
	
	line_item3 = LineItem.new(order_id: 1, product_id: 1, quantity: 1)
	assert line_item3.valid?
  end
end
