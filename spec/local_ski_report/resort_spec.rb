require 'spec_helper'

RSpec.describe LocalSkiReport::Resort do
  it 'is defined within lib/local_ski_report/resort.rb' do
    expect(defined?(LocalSkiReport::Resort)).to be_truthy
    expect(LocalSkiReport::Resort).to be_a(Class)
  end

  describe "#initialize" do
    it 'takes a hash, and returns an instance' do
      options = {
        name: 'Ober Gatlinburg',
        location: 'Gatlinburg',
        snowfall: {'24hr': '0', '72hr': '5'},
        url: 'https://www.onthesnow.com/california/donner-ski-ranch/skireport.html',
        base_depth: '120" - 160"',
        lifts: '4/6',
        open_acreage: '1000ac'
      }

      expect(LocalSkiReport::Resort.new(options)).to be_a(LocalSkiReport::Resort)
    end
  end

end
