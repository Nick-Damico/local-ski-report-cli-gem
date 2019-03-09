require "spec_helper"

class DummyClass
  include Formattable
end

RSpec.describe Formattable do
  describe '#separator' do
    it "it outputs a dashed line separator" do
      dc = DummyClass.new
      expect { dc.separator(5) }.to output("-----\n").to_stdout      
    end
  end
end
