require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :orders, :order_statuses, :statuses
  
  test "order cannot be deleted" do
	order = Order.find_by_id(orders(:one).id)
	assert !order.destroy
	order = Order.find_by_id(orders(:one).id)
	
	assert_not_nil order
  end
  
  test "order cannot be in the past" do
	order = Order.new(:ordered_at => "2013-02-13 15:24:30", :vat => 20.0)
	assert order.invalid?
	assert_equal ["can't be in the past"], order.errors[:ordered_at]
	
	# change ordered at date to a future date next year
	order.ordered_at = "2015-02-13 15:24:30"
	assert order.valid?
  end
  
  test "newly created order has a draft status" do
	order = Order.create(:ordered_at => "2015-02-13 15:24:30", :vat => 20.0)
	assert_equal 1, order.statuses.size
	assert_equal 'DRAFT', order.current_status.status_type
  end
  
  test "change order status to placed from draft" do
	order = Order.find_by_id(orders(:two).id)
	status = Status.find_by_id(statuses(:placed).id)
	order.statuses << status
	order.save
	
	assert order.valid? # this needs to pass valid test
  end
  
end
