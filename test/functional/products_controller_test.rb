require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
include AssertJson

  
  setup do
    @product = products(:one)
	@update = { 
		name: 'Check this',
		price: 9.99 
	}
  end

  test "should get index" do
    get :index
#    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
#    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update
    end

  end

  test "should show product" do
    get :show, id: @product.id
#    assert_equal "MyString", json['name']
	puts @response.body
#	assert_json(@response.body) do
#	  has 'name', 'MyString'
#	end
  end

  test "should get edit" do
#    get :edit, id: @product
#    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: { name: @product.name, price: @product.price }
  end

  test "should destroy product" do
    # Delete a product with no dependent items
	# Delete a product with dependent items
	#assert_difference('Product.count', -1) do
    #  delete :destroy, id: @product
    #end

  end
end
