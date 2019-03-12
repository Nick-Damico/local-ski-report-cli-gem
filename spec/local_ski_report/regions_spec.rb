require 'spec_helper'

RSpec.describe LocalSkiReport::Regions do
  describe 'LocalSkiResort::Regions' do
    it 'has a constant REGIONS_WITH_RESORTS' do end

    describe '.all_regions' do
      it 'returns an array region names' do
        expect(LocalSkiReport::Regions.all_regions).to eq(%w[MIDWEST NORTHEAST NORTHWEST ROCKIES SOUTHEAST WESTCOAST])
      end
    end

    describe '.all_states_in_region' do
      it 'returns an array of state names from a region' do
        # The parameter '2' refers to the region Northwest
        expect(LocalSkiReport::Regions.all_states_in_region(2)).to eq(%w[Alaska Idaho Oregon Washington])
      end
    end
  end
end
