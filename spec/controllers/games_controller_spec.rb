require 'rails_helper'

RSpec.describe GamesController do
  let(:payload) { JSON.parse(response.body) }
  let(:game) { Game.create(player1: 'AA', player2: 'BB') }

  context '#create' do
    it 'creates a game' do
      game = { game: { player1: 'AA', player2: 'BB' } }
      post :create, params: game
      expect(response).to have_http_status(:created)
    end

    it 'miss player1' do
      game = { game: { player1: nil, player2: 'BB' } }
      post :create, params: game

      expect(response).to have_http_status(:unprocessable_entity)
      expect(payload['errors'].length).to eq(1)
      expect(payload['errors'].keys).to include('player1')
    end
  end

  context '#show' do
    it 'shows a game' do
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end

    it 'gutter game zeroos' do
      20.times do
        Roll.create(game_id: game.id, player: game.player1, knocked_pins: 0)
        Roll.create(game_id: game.id, player: game.player2, knocked_pins: 0)
      end

      get :show, params: { id: game.id }
      expect(payload['score1']).to eq(0)
      expect(payload['score2']).to eq(0)
    end

    it 'spare' do
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 3)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 7)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 7)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 0)

      Roll.create(game_id: game.id, player: game.player2, knocked_pins: 0)
      get :show, params: { id: game.id }
      expect(payload['score1']).to eq(24)
      expect(payload['score2']).to eq(0)
    end

    it 'strike' do
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 10)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 5)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 3)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 3)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 3)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 0)

      Roll.create(game_id: game.id, player: game.player2, knocked_pins: 0)
      get :show, params: { id: game.id }
      expect(payload['score1']).to eq(38)
      expect(payload['score2']).to eq(0)
    end
    it 'normal rolls' do
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 3)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 4)
      Roll.create(game_id: game.id, player: game.player1, knocked_pins: 3)

      Roll.create(game_id: game.id, player: game.player2, knocked_pins: 3)
      Roll.create(game_id: game.id, player: game.player2, knocked_pins: 5)

      get :show, params: { id: game.id }

      expect(payload['score1']).to eq(10)
      expect(payload['score2']).to eq(8)
    end
  end
end
