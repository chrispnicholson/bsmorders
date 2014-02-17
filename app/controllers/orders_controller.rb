class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.json { render json: @orders }
    end
  end

  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.json { render json: @order.to_json }
    end
  end

  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.json { render json: @order.to_json }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders.json
  def create
    @order = Order.new(params[:order])
	@status = Status.new(:status_type => 'DRAFT')
	@order_status = @order.order_statuses.build
	@order_status.status = @status

    respond_to do |format|
      if @order.save
        format.json { render json: @order, status: :created, location: @order }
      else
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.json { head :no_content }
      else
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
	
	begin
      @order.destroy
	rescue ActiveRecord::DeleteRestrictionError
	  logger.error "Cannot delete live orders"
	  @order.errors[:cannot_delete_live_order] << 'Cannot delete live orders'
	end
	
    respond_to do |format|
      format.json { render json @order.errors }
    end
  end
end
