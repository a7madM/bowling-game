require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'game creation' do
    it 'creates a game' do
      game = Game.create(player1: 'A', player2: 'B')
      expect(Game.last).to be_present
      expect(Game.last).to eq(game)
      expect(Game.last.player1).to eq(game.player1)
    end
  end

  describe 'validation' do
    it { should validate_presence_of(:player1) }
    it { should validate_presence_of(:player2) }
  end
end
