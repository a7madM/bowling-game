require 'rails_helper'

RSpec.describe Roll, type: :model do
  context 'roll the ball' do
    it 'rolls the ball' do
      game = Game.create(player1: 'A', player2: 'B')
      Roll.create(player: '1', game_id: game.id)
    end
  end
end
