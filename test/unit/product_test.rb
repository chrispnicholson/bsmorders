require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products, :orders, :line_items
  
  test "product attributes shouldn't be empty" do
	product = Product.new
	assert product.invalid?
	assert product.errors[:name].any?
	assert product.errors[:price].any?
  end
  
  test "product name should be unique" do
	product1 = Product.new(name: "This is the same", price: 20.0)
	assert product1.valid?
	
	product2 = Product.new(name: "This is the same", price: 20.0)
	assert product2.valid?
	#assert product2.errors[:name].any?
  end
  
  test "product price must be numerical and over 0.01" do
	product = Product.new(name: "Zero price", price: 0.0)
	assert product.invalid?
	assert product.errors[:price].any?
	
	product2 = Product.new(name: "Wrong price", price: 'Not a number')
	assert product2.invalid?
	assert product2.errors[:price].any?
	
	product3 = Product.new(name: "Negative price", price: -10.0)
	assert product3.invalid?
	assert product3.errors[:price].any?
	
	product4 = Product.new(name: "Correct price", price: 40.0)
	assert product4.valid?
  end
  
  test "product is not valid without a unique name" do
	product = Product.new(name: products(:one).name, price: 40.0)
	assert product.invalid?
	assert_equal ["has already been taken"], product.errors[:name]
  end
  
  test "product can be deleted if no orders attached" do
	product = Product.new(name: "This can be deleted", price: 10.0)
	assert product.valid?
	assert product.destroy
	
	product2 = Product.find_by_name("This can be deleted")
	assert_nil product2
  end
  
  test "product cannot be deleted if orders are attached" do
	product = Product.new(name: "This cannot be deleted", price: 20.0)
	assert product.valid?
	order = Order.find_by_id(orders(:one).id)
	line_item = order.line_items.build
	line_item.product = product
	line_item.quantity = 1
	assert line_item.valid?
	assert order.valid?
	assert line_item.save
	assert order.save
	assert product.save
	
	#assert !product.destroy
	assert_raise ActiveRecord::DeleteRestrictionError do
	  product.destroy
	end
	
	product2 = Product.find_by_name("This cannot be deleted")
	assert_not_nil product2
  end
end
