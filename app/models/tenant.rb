class Tenant
  PROPERTIES = { 
    'pi' => { name: "PI",
              time_zone: "Central Time (US & Canada)", 
              area_divisor: 144.0, 
              small_area_cutoff: 2304, ##2304 (<16 to <9) 1296
              yield_multiplier: 1 },
    'pe' => { name: "PE",
              time_zone: "Beijing", 
              area_divisor: 1000000.0, 
              small_area_cutoff: 1500000, ##1500000 (<16 to <9) 836000
              yield_multiplier: 10.76 }
  }

  attr_reader :code, :name, :time_zone, :area_divisor, :small_area_cutoff, :yield_multiplier

  def initialize(code)
    @code = code
    @name = PROPERTIES["pi"][:name]
    @time_zone = PROPERTIES["pi"][:time_zone]
    @area_divisor = PROPERTIES["pi"][:area_divisor]
    @small_area_cutoff = PROPERTIES["pi"][:small_area_cutoff]
    @yield_multiplier = PROPERTIES["pi"][:yield_multiplier]
  end

  def self.asset_classes
    [User, FilmMovement, SalesOrder, MasterFilm, Film, Machine]
  end

  asset_classes.each do |klass|
    name = klass.name.pluralize.underscore.downcase.to_sym
    define_method(name) do
      klass.tenant(code)
    end
  end

  asset_classes.each do |klass|
    name = "new_#{klass.name.underscore.downcase}".to_sym
    define_method(name) do |*args|
      klass.new(*args).tap do |o|
        o.tenant_code = code
      end
    end
  end
end
