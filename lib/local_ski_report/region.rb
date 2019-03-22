class LocalSkiReport::Region
  include Formattable

  REGIONS_WITH_RESORTS = {
    midwest: %w[Illinois Indiana Iowa Kansas Michigan Minnesota Missouri Ohio Wisconsin],
    northeast: ["Connecticut", "Maine", "Massachusetts", "New Hampshire", "New Jersey", "New York", "Pennsylvania", "Rhode Island", "Vermont"],
    northwest: %w[Alaska Idaho Oregon Washington],
    rockies: ["Colorado", "Montana", "New Mexico", "Utah", "Wyoming"],
    southeast: ["Maryland", "North Carolina", "Tennessee", "Virginia", "West Virginia"],
    west_coast: %w[Arizona California Nevada]
  }.freeze

  def all_regions
    REGIONS_WITH_RESORTS.collect { |region, _v| format_to_string(region) }
  end

  def all_states_in_region(region_number)
    # convert string variable to symbol to access value in REGIONS_WITH_RESORTS
    REGIONS_WITH_RESORTS[downcase_to_sym(all_regions[region_number])]
  end

  def get_state(region_num, state_num)
    all_states_in_region(region_num)[state_num]
  end
end
