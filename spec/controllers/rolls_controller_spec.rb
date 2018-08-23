require 'rails_helper'

RSpec.describe RollsController, type: :controller do
  let(:payload) { JSON.parse(response.body) }
  game = Game.create(player1: 'AA', player2: 'BB')
  roll = { game_id: game.id, player: game.player1, knocked_pins: 5 }

  context '#create' do
    it 'rolls the ball' do
      post :create, params: { roll: roll }

      expect(response).to have_http_status(:created)
      expect(payload['roll']['id']).to eq(Roll.last.id)
    end
  end
end
