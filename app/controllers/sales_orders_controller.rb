class SalesOrdersController < ApplicationController
  before_action :check_admin, only: [:destroy]
  # require 'csv'
  
  def index
    @sales_orders = filtered_orders.order_by(sort[0], sort[1]).page(params[:page])
    @sales_orders1 = filtered_orders.order_by(sort[0], sort[1])
    if params[:status]=='shipped'
     @sales_orders=filtered_orders.where(['ship_date < ? AND ship_date > ?', Date.today,Date.today - 1.year]).page(params[:page])
     @sales_orders1 =  filtered_orders.where(['ship_date < ? AND ship_date > ?', Date.today,Date.today - 1.year])
    end
    if params[:status1] == '1year'
      params['status'] = 'shipped'
       @sales_orders = filtered_orders.where(['ship_date < ?', Date.today - 1.year]).page(params[:page])
       @sales_orders1 = filtered_orders.where(['ship_date < ?', Date.today - 1.year])
    end
    respond_to do |format|
      format.html
      format.csv do 
        render csv: filtered_orders if params[:data] == "orders"
        render csv: filtered_orders.line_items if params[:data] == "line_items" 
      end
    end
  end

  def lead_time_histogram
    @histogram = LeadTimeHistogram.new(filtered_orders)
  end

  def product_type_totals
    @data = LineItemProductTypeTotals.new(filtered_orders.line_items)
  end

  def assigned_formula_totals
    @data = FilmFormulaTotals.new(filtered_orders.films)
    render 'films/formula_totals'
  end
  
  def new
    @sales_order = current_tenant.new_sales_order
    render layout: false
  end

  def create
    @sales_order = current_tenant.new_sales_order(order_params)
    unless @sales_order.save
      render :display_modal_error_messages, locals: { object: @sales_order }
    end
  end

  def edit 
    session[:return_to] ||= request.referer
    @sales_order = sales_orders.find(params[:id])
    render layout: false
  end

  def update
    @sales_order = sales_orders.find(params[:id])
    unless @sales_order.update_attributes(order_params)
      render :display_modal_error_messages, locals: { object: @sales_order }
    end
  end
  
   def duplicate_update
    new_line_item = LineItem.find_by_id(params[:format])
    sales_order = SalesOrder.find(new_line_item.sales_order_id)
    if new_line_item.dup.save!
      redirect_back(fallback_location: root_path, flash: {notice: "Successfully LineItems is added"})
    end
  end
  def move
    @sales_order = sales_orders.find(params[:id])
    @sales_order.status = params[:destination]
    @sales_order.save!
  end

  def destroy
    @sales_order = sales_orders.find(params[:id])
    @sales_order.destroy!
    redirect_to session.delete(:return_to), notice: "Order #{@sales_order.code} deleted."
  end

  def edit_ship_date
    @sales_order = sales_orders.find(params[:id])
    render layout: false
  end

  def update_ship_date
    @sales_order = sales_orders.find(params[:id])
    if @sales_order.update_attributes(order_params)
      @sales_order.shipped!
    else
      render :display_modal_error_messages, locals: { object: @sales_order }
    end
  end
 
 
  private

  def filtered_orders
    return sales_orders.where("ship_date < ?", Date.today - 1.year).shipped if params[:status1] == "1year" && params[:action] == "lead_time_histogram" #1 year old lead time histogram issue 
    return sales_orders.where("ship_date < ?", Date.today - 1.year).shipped if params[:status1] == "1year" && params[:action] == "product_type_totals" #1 year product type totals 
    return sales_orders.where("ship_date < ?", Date.today - 1.year).shipped if params[:status1] == "1year" && params[:action] == "assigned_formula_totals" #1 year assigned formula totals. 
    orders = sales_orders.status(params[:status]) #filter.(filtering_params) (Ruby 2.5.1 > 2.6.8)
    orders = orders.search(filtering_params[:text_search]) if filtering_params[:text_search].present?

    orders
  end
  helper_method :filtered_orders

  def sales_orders
    current_tenant.sales_orders
  end
  helper_method :sales_orders

  def sort
    params.fetch(:sort) do
      'code-desc'
    end.split('-')
  end
  helper_method :sort

  def filtering_params
    params.slice(:text_search, :code_like, :ship_date_before, :ship_date_after)
  end

  def order_params
    params.require(:sales_order).permit(:code, :customer, :ship_to, :release_date, :due_date, :ship_date, :note, :line_items_attributes, :status, line_items_attributes: [:custom_width, :custom_length, :quantity, :product_type, :wire_length, :busbar_type, :note, :id, :_destroy])
  end
end
