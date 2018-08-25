require 'swagger_helper'
describe 'rolls API' do
  path '/rolls' do
    post 'Creates a roll' do
      tags 'Rolls'
      consumes 'application/json', 'application/xml'
      parameter name: :roll, in: :body, schema: {
        type: :object,
        properties: {
          player: { type: :string },
          knocked_pins: { type: :integer },
          game_id: { type: :integer }
        },
        required: %w[player knocked_pins game_id]
      }

      response '201', 'roll created' do
        let(:roll) { { player: 'AA', player2: 'BB' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:roll) { { player: 'foo' } }
        run_test!
      end
    end
  end
end
