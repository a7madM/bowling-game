require 'rails_helper'

RSpec.describe RollsController, type: :controller do
  let(:payload) { JSON.parse(response.body) }
  game = Game.create(player1: 'AA', player2: 'BB')
  roll = { game_id: game.id, player: game.player1, knocked_pins: 5 }
  zero_roll = { game_id: game.id, player: game.player1, knocked_pins: 0 }
  strike_roll = { game_id: game.id, player: game.player1, knocked_pins: 10 }
  roll_without_player = { game_id: game.id, player: '', knocked_pins: 10 }

  context '#create' do
    it 'rolls the ball' do
      post :create, params: { roll: roll }

      expect(response).to have_http_status(:created)
      expect(payload['roll']['id']).to eq(Roll.last.id)
    end

    it 'rolls zero' do
      post :create, params: { roll: zero_roll }
      expect(response).to have_http_status(:created)
      expect(payload['roll']['knocked_pins']).to eq(0)
    end

    it 'creates empty roll to finish the frame' do
      post :create, params: { roll: strike_roll }

      expect(response).to have_http_status(:created)
      expect(payload['roll']['id'] + 1).to eq(Roll.last.id)
      expect(Roll.count).to eq(2)
    end

    it 'miss player' do
      post :create, params: { roll: roll_without_player }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(payload['errors']).to include('player')
    end
  end
end
