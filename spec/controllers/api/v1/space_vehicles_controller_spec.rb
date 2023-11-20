require 'rails_helper'

module Api
  module V1
    RSpec.describe SpaceVehiclesController, type: :request do
      let!(:api_token) { create(:api_token) }

      setup do
        vehicle = create(:space_vehicle)
      end

      context 'When credentials are invalid' do
        it 'returns Bad credentials' do
          get api_v1_space_vehicles_path

          parsed_body = JSON.parse(response.body)

          expect(response.code).to eq '401'
        end
      end

      context 'When credentials are valid' do
        describe 'GET #index' do
          it 'returns vehicles' do
            get api_v1_space_vehicles_path, headers: { Authorization: "Bearer #{api_token.token}" }

            parsed_body = JSON.parse(response.body)
            expect(response.code).to eq '200'
          end
        end
      end
    end
  end
end
