require "spec_helper"

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
      
    end
  end
end
