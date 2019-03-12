require 'spec_helper'

RSpec.describe LocalSkiReport::Regions do
  before(:each) do
    @Local_ski_report_regions = LocalSkiReport::Regions
  end
  describe 'LocalSkiReport::Regions' do
    it 'has a constant REGIONS_WITH_RESORTS' do end

    describe '.all_regions' do
      it 'returns an array region names' do
        expect(@Local_ski_report_regions.all_regions).to eq(%w[MIDWEST NORTHEAST NORTHWEST ROCKIES SOUTHEAST WESTCOAST])
      end
    end

    describe '.all_states_in_region' do
      it 'returns an array of state names from a region' do
        # The parameter '2' refers to the region Northwest
        expect(@Local_ski_report_regions.all_states_in_region(2)).to eq(%w[Alaska Idaho Oregon Washington])
      end
    end

    describe '.get_state' do
      it 'returns the name of the user selected state' do
        expect(@Local_ski_report_regions.get_state(0, 1)).to eq("Indiana")
      end
    end
  end
end
