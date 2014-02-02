class SalesOrdersController < ApplicationController
  before_filter :check_admin, only: [:destroy, :return]

  def index
    @sales_orders = current_tenant.widgets(SalesOrder)
                                  .send(params[:scope])
                                  .text_search(params[:query])
                                  .by_code
                                  .page(params[:page])
  end
  
  def new
    @sales_order = SalesOrder.new
    render layout: false
  end

  def create
    @sales_order = SalesOrder.create(params[:sales_order])
  end

  def edit 
    @sales_order = SalesOrder.find(params[:id])
    render layout: false
  end

  def update
    @sales_order = SalesOrder.find(params[:id])
    @sales_order.update_attributes(params[:sales_order])
  end

  def destroy
    @sales_order = SalesOrder.find(params[:id])
    @sales_order.destroy
  end

  def edit_ship_date
    @sales_order = SalesOrder.find(params[:id])
    render layout: false
  end

  def update_ship_date
    @sales_order = SalesOrder.find(params[:id])
    @sales_order.update_attributes(params[:sales_order])
  end

  def return
    @sales_order = SalesOrder.find(params[:id])
    @sales_order.update_attributes(ship_date: nil)
  end
end
