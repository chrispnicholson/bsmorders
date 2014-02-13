require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, line_item: { order_id: @line_item.order_id, product_id: @line_item.product_id, quantity: @line_item.quantity }
    end

  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    put :update, id: @line_item, line_item: { order_id: @line_item.order_id, product_id: @line_item.product_id, quantity: @line_item.quantity }
  end

  test "should destroy line_item" do
##    assert_difference('LineItem.count', -1) do
 ##     delete :destroy, id: @line_item
##    end

  end
end
