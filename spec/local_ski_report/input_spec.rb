require 'spec_helper'

RSpec.describe LocalSkiReport::Input do
  before(:each) do
    @input = LocalSkiReport::Input.new
  end
  describe '#correct_input_range' do
    it 'returns true when a number is inside of a range' do
      expect(@input.correct_input_range(5, 10)).to eq(true)
    end

    it 'returns false when a number is outside of a range' do
      allow($stdout).to receive(:puts)
      expect(@input.correct_input_range(10, 5)).to eq(false)
    end

    it 'prompts a user to select a number' do
      allow($stdout).to receive(:puts)
      allow(@input).to receive(:gets).at_least(:once).and_return("1")

      expect(@input.number_selection).to eq(1)
    end
  end
end

# game = TicTacToe.new
#  allow($stdout).to receive(:puts)
#  allow(game).to receive(:over?).and_return(false, true)
#
#  expect(game).to receive(:gets).at_least(:once).and_return("1")
#
#  game.play
