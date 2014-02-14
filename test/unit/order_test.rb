require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :orders
  
  test "order cannot be deleted" do
	order = Order.find_by_id(orders(:one).id)
	order.destroy
	order = Order.find_by_id(orders(:one).id)
	
	assert_not_nil order
  end
  
  test "order cannot be in the past" do
	a_day_ago_in_seconds = Time.now - (60*60*25)
	
	order_date = Time.now
	order = Order.new(order_date, 20.0)
	assert order.invalid?
	assert_equal ["can't be in the past"], product.errors[:ordered_at]
  end
end
