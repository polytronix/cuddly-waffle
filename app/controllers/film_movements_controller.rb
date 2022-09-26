class FilmMovementsController < ApplicationController
  before_action :set_default_start_date

  def index
    @film_movements = film_movements.sort_by_created_at.page(params[:page])

    @film_movements = @film_movements.to_phase(filtering_params[:to_phase]) if filtering_params[:to_phase].present?
    @film_movements = @film_movements.from_phase(filtering_params[:from_phase]) if filtering_params[:from_phase].present?
    @film_movements = @film_movements.search(filtering_params[:text_search]) if filtering_params[:text_search].present?
    @film_movements = @film_movements.created_at_before(filtering_params[:created_at_before]) if filtering_params[:created_at_before].present?
    @film_movements = @film_movements.created_at_after(filtering_params[:created_at_after]) if filtering_params[:created_at_after].present?

    @film_movements

    respond_to do |format|
      format.html
      format.csv { render csv: film_movements }
    end
  end

  def map
    map = FilmMovementsMap.new(film_movements)
    @categories = map.categories
    @map_data = map.data
  end

  def inventory_totals
    @time_series = InventoryTotals.new(tenant_movements, current_tenant)
  end

  private

  def tenant_movements
    current_tenant.film_movements.exclude_deleted_films
  end

  def film_movements 
    tenant_movements  # .filter(filtering_params) (Ruby 2.5 to 2.6)
  end

  def filtering_params
    params.slice(:text_search, :from_phase, :to_phase, :created_at_before, :created_at_after)
  end

  def set_default_start_date
    params[:created_at_after] ||= Date.current
  end
end
