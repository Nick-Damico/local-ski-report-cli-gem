require 'spec_helper'

RSpec.describe LocalSkiReport::Output do
  before(:each) do
    @output = LocalSkiReport::Output.new
  end
  describe '.list_regions' do
    it 'outputs to terminal a numbered list of regions' do
      expect { @output.list_regions }.to output("1. MIDWEST\n2. NORTHEAST\n3. NORTHWEST\n4. ROCKIES\n5. SOUTHEAST\n6. WESTCOAST\n").to_stdout
    end
  end

  describe '.list_states' do
    it 'outputs to terminal a numbered list of states from a region' do
      expect { @output.list_states(0) }.to output("1. Illinois\n2. Indiana\n3. Iowa\n4. Kansas\n5. Michigan\n6. Minnesota\n7. Missouri\n8. Ohio\n9. Wisconsin\n").to_stdout
    end
  end
end
