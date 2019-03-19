require 'spec_helper'

class DummyClass
  include Formattable
end

RSpec.describe Formattable do
  describe '#separator' do
    it 'outputs a dashed line separator' do
      dc = DummyClass.new
      expect { dc.separator(5) }.to output("-----\n").to_stdout
    end
  end

  describe '#numbered_collection' do
    it 'formats a collection into a numbered collection' do
      dc = DummyClass.new
      region = LocalSkiReport::Region.new
      region_collection = region.all_states_in_region(2)
      expect(dc.numbered_collection(region_collection)).to eq(['1. Alaska', '2. Idaho', '3. Oregon', '4. Washington'])
    end
  end

  describe '#urlify' do
    it 'takes the name of a state as an argument, formats them for url queries' do
      dc = DummyClass.new
      expect(dc.urlify('Tennessee')).to eq('tennessee')
      expect(dc.urlify('North Carolina')).to eq('north_carolina')
      expect(dc.urlify('New York')).to eq('new_york')
    end
  end
end
