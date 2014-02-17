require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
include AssertJson

  setup do
    @order = orders(:one)
	@update = { 
		ordered_at: '2015-02-12 17:21:35',
		vat: 20.00
	}
	@delete = orders(:two)
  end

  test "should get index" do
    get :index
    assert_not_nil assigns(:orders)
	
  end

  test "should get new" do
    get :new

  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: @update
    end

  end

  test "should show order" do
    get :show, id: @order, :format => 'json'
	
	assert_json(@response.body) do
	  has 'ordered_at', '2015-02-12T17:21:35Z'
      has 'vat', '20.0'
	end
  end

  test "should get edit" do
    get :edit, id: @order
    #assert_response :success
  end

  test "should update order from draft order with line items to placed" do
    put :update, id: @update, order: { ordered_at: @update.ordered_at, vat: @update.vat }
  end

  test "should destroy order" do
#    assert_difference('Order.count', -1) do
#      delete :destroy, id: @delete
#    end

    #assert_redirected_to orders_path
  end
end
