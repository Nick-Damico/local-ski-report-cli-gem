require 'spec_helper'

RSpec.describe LocalSkiReport::Regions do
  describe 'LocalSkiResort::Regions' do
    it 'has a constant REGIONS_WITH_RESORTS' do end

    describe '.all_regions' do
      it 'returns an array of numbered, string formatted region names' do
        expect(LocalSkiReport::Regions.all_regions).to eq(%w[MIDWEST NORTHEAST NORTHWEST ROCKIES SOUTHEAST WESTCOAST])
      end
    end

    describe '.all_states_in_region' do
      it 'returns an array of numbered, string formatted state names' do
        # The parameter '2' refers to the region Northwest
        expect(LocalSkiReport::Regions.all_states_in_region(2)).to eq(%w[Alaska Idaho Oregon Washington])
      end
    end
  end
end

# test_case = ['1. MIDWEST', '2. NORTHEAST', '3. NORTHWEST', '4. ROCKIES', '5. SOUTHEAST', '6. WEST COAST']
# test_case = ['1. Alaska', '2. Idaho', '3. Oregon', '4. Washington']
