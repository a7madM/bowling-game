require 'swagger_helper'
describe 'games API' do
  path '/games' do
    post 'Creates a game' do
      tags 'Games'
      consumes 'application/json', 'application/xml'
      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          player1: { type: :string },
          player2: { type: :string }
        },
        required: %w[player1 player2]
      }

      response '201', 'game created' do
        let(:game) { { player1: 'AA', player2: 'BB' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:game) { { player1: 'foo' } }
        run_test!
      end
    end
  end

  path '/games/:id' do
    get 'Show game and its score' do
      tags 'Games'
      consumes 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer }
        },
        required: %w[id]
      }

      response '200', 'name found' do
        schema name: :game, in: :body, type: :object,
               properties: {
                 game: { type: :object },
                 id: { type: :integer },
                 player1: { type: :string },
                 player2: { type: :string }
               },
               required: %w[id player1 player2]

        let(:id) { Game.create(player1: 'AA', player2: 'BB').id }
        run_test!
      end
    end
  end
end
