class ShipmentsController < ApplicationController
  before_action :set_default_start_date

  def index
    @shipments = Kaminari.paginate_array(grouped_shipments.reverse).page(params[:page])
  end

  def utilization_time_series
    @time_series = UtilizationTimeSeries.new(grouped_shipments)
  end

  def shipped_area_time_series
    @time_series = ShippedAreaTimeSeries.new(grouped_shipments)
  end

  private
  
  def grouped_shipments
    TimeSeriesGrouper.new(filtered_shipped_orders, 'ship_date').send(params[:grouping])
  end

  def filtered_shipped_orders
    shipped_orders = current_tenant.sales_orders.shipped #.filter(filtering_params) (Ruby 2.5 to 2.6)
    shipped_orders = shipped_orders.ship_date_before(filtering_params[:ship_date_before]) if filtering_params[:ship_date_before].present?
    shipped_orders = shipped_orders.ship_date_after(filtering_params[:ship_date_after]) if filtering_params[:ship_date_after].present?

    shipped_orders
  end

  def set_default_start_date
    params[:ship_date_after] ||= 1.month.ago.to_date
  end

  def filtering_params
    params.slice(:ship_date_before, :ship_date_after)
  end
end
