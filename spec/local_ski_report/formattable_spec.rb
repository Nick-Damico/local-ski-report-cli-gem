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
      region_collection = LocalSkiReport::Region.all_states_in_region(2)
      expect(dc.numbered_collection(region_collection)).to eq(['1. Alaska', '2. Idaho', '3. Oregon', '4. Washington'])
    end
  end
end
