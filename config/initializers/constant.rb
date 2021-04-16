PROPERTIES = { 
    'pi' => { name: "PI",
              time_zone: "Central Time (US & Canada)", 
              area_divisor: 144.0, 
              small_area_cutoff: 1296, ##2304 (<16 to <9)
              yield_multiplier: 1 },
    'pe' => { name: "PE",
              time_zone: "Beijing", 
              area_divisor: 1000000.0, 
              small_area_cutoff: 836000.0, ##1500000 (<16 to <9)
              yield_multiplier: 10.76 }
  }