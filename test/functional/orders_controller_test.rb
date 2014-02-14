require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
include AssertJson

  setup do
    @order = orders(:one)
	@update = { 
		ordered_at: '2014-02-12 17:21:35',
		vat: 20.00
	}
	@delete = orders(:two)
  end

  test "should get index" do
    get :index
    #assert_response :success
	puts @response.body
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    #assert_response :success
  end

  test "should create order" do
#    assert_difference('Order.count') do
#      post :create, order: @one
#    end

    #assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order, :format => 'json'
    
	assert_json(@response.body) do
	  has 'ordered_at', '2014-02-12T17:21:35Z'
      has 'vat', '20.0'
	end
  end

  test "should get edit" do
    get :edit, id: @order
    #assert_response :success
  end

  test "should update order" do
    put :update, id: @order, order: { ordered_at: @order.ordered_at, vat: @order.vat }
    #assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
#    assert_difference('Order.count', -1) do
#      delete :destroy, id: @delete
#    end

    #assert_redirected_to orders_path
  end
end
