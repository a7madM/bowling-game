require 'rails_helper'

RSpec.describe GamesController do
  let(:payload) { JSON.parse(response.body) }
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
      game = Game.create(player1: 'AA', player2: 'BB')
      get :show, params: { id: game.id }
      puts payload
      expect(response).to have_http_status(:success)
    end
  end
end
