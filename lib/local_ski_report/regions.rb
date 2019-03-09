class LocalSkiReport::Regions
  REGIONS_WITH_RESORTS = [
    { midwest: %w[Illinois Indiana Iowa Kansas Michigan Minnesota Missouri Ohio Wisconsin] },
    { northeast: %w[Connecticut Maine Massachusetts New Hampshire New Jersey New York Pennsylvania Rhode Island Vermont] },
    { northwest: %w[Alaska Idaho Oregon Washington] },
    { rockies: %w[Colorado Montana New Mexico Utah Wyoming] },
    { southeast: %w[Alabama Georgia Maryland North Carolina Tennessee Virginia West Virginia] },
    { west_coast: %w[Arizona California Nevada] }
  ].freeze

  def self.all_regions
    REGIONS_WITH_RESORTS.map.with_index(1) do |region, i|
      region.each_key.map do |k|
        "#{i}. #{k.to_s.tr('_', ' ').upcase}"
      end
    end.flatten
  end

  def self.all_states_in_region(num)
    REGIONS_WITH_RESORTS[num].each_value.map do |states|
      states.map.with_index(1) { |state, i| "#{i}. #{state}" }
    end.flatten
  end
end
