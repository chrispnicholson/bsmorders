class LineItemsController < ApplicationController
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.json { render json: @line_item.to_json(include:{product: {:only => :name}}) }
    end
  end

  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.json { render json: @line_item.to_json(include:{product: {:only => :name}}) }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
	@order = Order.find(params[:order_id])
    @line_item = @order.line_items.build
	@line_item.product = product

    respond_to do |format|
      if @line_item.save
        format.json { render json: @line_item.to_json(include:{product: {:only => :name}}), status: :created, location: @line_item }
      else
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.json { head :no_content }
      else
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
