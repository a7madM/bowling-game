require 'rails_helper'

RSpec.describe Roll, type: :model do
  context '#valid' do
    it 'creates the ball' do
      game = Game.create(player1: 'A', player2: 'B')
      Roll.create(player: '1', game_id: game.id)
    end
  end

  context 'validation' do
    it { should validate_presence_of(:game) }
    it { should validate_presence_of(:player) }
    it { should validate_presence_of(:knocked_pins) }
    it { should validate_inclusion_of(:knocked_pins).in_range(0..10) }
  end
end
