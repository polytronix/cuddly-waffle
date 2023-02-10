class FilmsController < ApplicationController
  require 'rqrcode'

  def index
    puts"in index"
    @films  = Kaminari.paginate_array(filtered_films.uniq).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.csv { render csv: filtered_films }
    end
  end
 
  def formula_totals
    @data = FilmFormulaTotals.new(filtered_films, params)
  end

  def dimensions_map
    @data = DimensionsMap.new(filtered_films)
  end

  def shelf_inventory
    @shelves = filtered_films.has_shelf.group_by(&:shelf).sort_by { |k,v| k }
  end

  def solder_series
    @data = SolderSeries.new(filtered_films)
  end

  def edit
    session[:return_to] ||= request.referer
    @film = tenant_films.find(params[:id])
    render layout: false
  end

  def update
    @film = tenant_films.find(params[:id])
    unless @film.update_and_move(film_params, params[:destination], current_user)
      render :display_modal_error_messages, locals: { object: @film }
    end
  end 

  def edit_multiple
    @films = tenant_films.find(params[:film_ids])
    if params[:edit]
      render :edit_multiple, layout: false
    elsif params[:qrcodes]
      render :qr_codes, layout: false
    end
  end

  def update_multiple
    @films = tenant_films.find(params[:film_ids])
    @films.each do |film|
      film.update_and_move(update_multiple_films_params, params[:destination], current_user)
    end
  end

  def split
    @film = tenant_films.find(params[:id])
    @split = @film.split
  end

  def destroy
    @film = tenant_films.find(params[:id])
    @film.update_attributes(deleted: true)
    redirect_to session.delete(:return_to), notice: "Film #{@film.serial} deleted."
  end

  def restore
    @film = tenant_films.find(params[:id])
    @film.update_attributes(deleted: false)
  end
  def delete_data
    @film = Film.find_by_id(params[:id])
    @film.destroy
    redirect_to root_path
  end


  private

  def tenant_films
    @tenant_films ||= current_tenant.films
  end
  helper_method :tenant_films

  def filtered_films
    # if params[:text_search].present?
      # @filtered_films ||= tenant_films.search(params[:text_search]).phase(params[:phase], current_tenant).sort_by(&:serial).reverse #It convert record to array
    #  @filtered_films ||= tenant_films.search(params[:text_search]).phase(params[:phase], current_tenant).order(serial: :desc) 
    #else
      # @filtered_films ||= tenant_films.phase(params[:phase], current_tenant).sort_by(&:serial).reverse #It convert record to array
    #  if params[:phase] == Film::PHASE[1] || params[:phase] == Film::PHASE[2]
    #    @filtered_films ||= tenant_films.phase(params[:phase], current_tenant).order(serial: :desc)
    #  else
    #    @filtered_films ||= tenant_films.phase(params[:phase], current_tenant)
    #  end
    #end
    @filtered_films = tenant_films.phase(params[:phase], current_tenant)&.order(serial: :desc) #film download Film Tab
    #@filtered_films = tenant_films.phase(params[:phase], current_tenant).order(serial: :desc)
    @filtered_films = @filtered_films.search(params[:text_search]).phase(params[:phase], current_tenant).order(serial: :desc)  if params[:text_search].present?
    @filtered_films = @filtered_films.joins(:dimensions).where("dimensions.width >= :min_width AND dimensions.length >= :min_length", min_width: params[:width_greater_than], min_length: params[:length_greater_than]) if dimensions_searched?
    @filtered_films = @filtered_films.phase(params[:phase], current_tenant).where('formula ILIKE ?', params[:formula_like].upcase.gsub('*', '%')).order(serial: :asc) if params[:formula_like].present?
    # if params[:formula_like].present?
    #@filtered_films = tenant_films.phase(params[:phase], current_tenant).where('formula ILIKE ?', params[:formula_like].upcase.gsub('*', '%')).order(serial: :asc) if params[:formula_like].present?
    return @filtered_films.where('serial_date BETWEEN ? AND ?', params[:serial_date_after], params[:serial_date_before]) if params[:serial_date_after].present? && params[:serial_date_before].present?

    # return @filtered_films.where('serial_date BETWEEN ? AND ?', params[:serial_date_after], params[:serial_date_before]) if params[:serial_date_after].present? && params[:serial_date_before].present?
   
   #  @filtered_films.uniq # fixed count by film not by film size
  #  @filtered_films
     @filtered_films.sort_by(&:serial_date).reverse
  end
  helper_method :filtered_films

  def dimensions_searched?
    params[:width_greater_than].present? || params[:length_greater_than].present?
  end

  def sort
    params.fetch(:sort) do
      dimensions_searched? ? 'area-asc' : 'serial-desc'
    end.split('-')
  end
  helper_method :sort

  def filtering_params
    params.slice(:text_search, :formula_like, :width_greater_than, :length_greater_than, :serial_date_before, :serial_date_after)
  end

  def film_params
    params.require(:film).permit(:note, :shelf, :sales_order_id, :order_fill_count,
                                 dimensions_attributes: [:width, :length, :_destroy, :id],
                                 solder_measurements_attributes: [:height1, :height2, :_destroy, :id])
  end

  def update_multiple_films_params
    params.require(:film).reject { |k,v| v.blank? }.permit(:shelf, :sales_order_id)
  end
end
