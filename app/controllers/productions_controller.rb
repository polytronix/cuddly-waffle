class ProductionsController < ApplicationController
  before_action :set_default_start_date

  def index
    @productions = Kaminari.paginate_array(grouped_productions.reverse).page(params[:page]) #grouped_productions
  end

  def yield_time_series
    @time_series = YieldTimeSeries.new(grouped_productions)
  end

  def produced_area_time_series #Produced Area (History>Production>Produced Area)
    @time_series = ProducedAreaTimeSeries.new(grouped_productions, filtered_production_master_films)
  end

  def defects_time_series
    @time_series = DefectsTimeSeries.new(grouped_productions, filtered_production_master_films)
  end

  private
  
  def grouped_productions
    TimeSeriesGrouper.new(filtered_production_master_films, 'serial_date').send(params[:grouping])
    #TimeSeriesGrouper.new(filtered_production_master_films, 'serial_date').by_day
  end

  def filtered_production_master_films
    production_master_films = current_tenant.master_films.active
    production_master_films = production_master_films.formula_like(filtering_params[:formula_like]) if filtering_params[:formula_like].present?
    production_master_films = production_master_films.serial_date_after(filtering_params[:serial_date_after]) if filtering_params[:serial_date_after].present?
    production_master_films = production_master_films.serial_date_before(filtering_params[:serial_date_before]) if filtering_params[:serial_date_before].present?

    production_master_films
  end

  def set_default_start_date
    params[:serial_date_after] ||= 1.month.ago.to_date
  end

  def filtering_params
    params.slice(:serial_date_before, :serial_date_after, :formula_like)
  end
end
