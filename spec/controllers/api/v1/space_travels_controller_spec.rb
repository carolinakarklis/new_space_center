require 'rails_helper'

module Api
  module V1
    RSpec.describe SpaceTravelsController, type: :request do
      let!(:api_token) { create(:api_token) }
      let!(:space_travel) { create(:space_travel) }

      describe 'GET #index' do
        it 'returns space travels' do
          get api_v1_space_travels_path, headers: { Authorization: "Bearer #{api_token.token}" }

          parsed_body = JSON.parse(response.body)

          expect(parsed_body["data"].count).to eq 1
          expect(response.code).to eq '200'
        end
      end

      describe 'POST #create' do
        let!(:space_vehicle_a) { create(:space_vehicle) }
        let!(:planet) { create(:planet) }
        let(:travel_params) do
          {
            space_travel: {
              start_at: DateTime.new(2023,12,10,5,0,0).to_s,
              planet_id: planet.id,
              space_vehicle_id: space_vehicle_a.id,
              mission_description: 'New mission to Venus'
            }
          }
        end

        context 'when vehicle has enough fuel' do
          it 'creates space travel' do
            post api_v1_space_travels_path, params: travel_params, headers: { Authorization: "Bearer #{api_token.token}" }
  
            parsed_body = JSON.parse(response.body)
  
            expect(response.status).to eq(200)
            expect(parsed_body["data"]["attributes"]["status"]).to eq("scheduled")
            expect(parsed_body["data"]["attributes"]["mission_description"]).to eq(travel_params[:space_travel][:mission_description])
          end
        end

        context 'when vehicle lacks fuel' do
          let!(:no_fuel_rocket) { create(:rocket, fuel_days: 0) }
          let!(:no_fuel_vehicle) { create(:space_vehicle, vehicleable: no_fuel_rocket )}
          let(:no_fuel_params) do
            {
              space_travel: {
                planet_id: planet.id,
                space_vehicle_id: no_fuel_vehicle.id,
                mission_description: 'New mission to Venus'
              }
            }
          end

          it 'does not create space travel' do
            post api_v1_space_travels_path, params: no_fuel_params, headers: { Authorization: "Bearer #{api_token.token}" }
  
            parsed_body = JSON.parse(response.body)

            expect(response.status).to eq(422)
            expect(parsed_body["data"]["attributes"]["errors"]["space_vehicle"]).to eq ["vehicle hasn't enough fuel to schedule travel"]
          end
        end
      end
    end
  end
end
