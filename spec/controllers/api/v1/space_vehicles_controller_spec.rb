require 'rails_helper'

module Api
  module V1
    RSpec.describe SpaceVehiclesController, type: :request do
      let!(:api_token) { create(:api_token) }
      let!(:space_vehicle_a) {create(:space_vehicle) }
      let!(:space_vehicle_b) {create(:space_vehicle) }

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

            expect(parsed_body["data"].count).to eq 2
            expect(response.code).to eq '200'
          end
        end

        describe 'POST #create' do
          let(:rocket_params) do
            {
              space_vehicle: {
                km_per_hour: 100,
                name: 'Big Rocket',
                agency_id: create(:agency).id,
                rocket_attributes: {
                  fuel_days: 20,
                  load_type_name: 'satellite',
                  load_type_weight: 30,
                  load_type_description: 'Lorem ipsum'
                }
              }
            }
          end

          let(:space_bus_params) do
            {
              space_vehicle: {
                km_per_hour: 100,
                name: 'Bus 3.0',
                agency_id: create(:agency).id,
                space_bus_attributes: {
                  fuel_days: 10,
                  max_crew: 20
                }
              }
            }
          end

          let(:alien_ship_params) do
            {
              space_vehicle: {
                km_per_hour: 100,
                name: 'Millennium Falcon',
                agency_id: create(:agency).id,
                alien_ship_attributes: {
                  abductions_number: 50,
                  max_crew: 10
                }
              }
            }
          end

          it 'creates rocket vehicle' do
            post api_v1_space_vehicles_path, params: rocket_params, headers: { Authorization: "Bearer #{api_token.token}" }

            expect(response.status).to eq(200)
            expect(SpaceVehicle.last.name).to eq rocket_params[:space_vehicle][:name]
            expect(Rocket.last.fuel_days).to eq rocket_params[:space_vehicle][:rocket_attributes][:fuel_days]
          end

          it 'creates space bus vehicle' do
            post api_v1_space_vehicles_path, params: space_bus_params, headers: { Authorization: "Bearer #{api_token.token}" }

            expect(response.status).to eq(200)
            expect(SpaceVehicle.last.name).to eq space_bus_params[:space_vehicle][:name]
            expect(SpaceBus.last.fuel_days).to eq space_bus_params[:space_vehicle][:space_bus_attributes][:fuel_days]
          end

          it 'creates alien ship vehicle' do
            post api_v1_space_vehicles_path, params: alien_ship_params, headers: { Authorization: "Bearer #{api_token.token}" }

            expect(response.status).to eq(200)
            expect(SpaceVehicle.last.name).to eq alien_ship_params[:space_vehicle][:name]
            expect(AlienShip.last.max_crew).to eq alien_ship_params[:space_vehicle][:alien_ship_attributes][:max_crew]
          end
        end

        describe 'PUT #update' do
          context 'when params are valid' do
            let(:update_params) do
              {
                space_vehicle: {
                  name: 'New vehicle name',
                  km_per_hour: 1000,
                  fuel_days: 50
                }
              }
            end

            it 'updates vehicle' do
              put api_v1_space_vehicle_path(space_vehicle_a), params: update_params, headers: { Authorization: "Bearer #{api_token.token}" }

              expect(response.status).to eq(200)
              expect(space_vehicle_a.reload.name).to eq update_params[:space_vehicle][:name]
              expect(space_vehicle_a.vehicleable.reload.fuel_days).to eq update_params[:space_vehicle][:fuel_days]
            end
          end

          context 'when new fuel_days value is not enough for current travels' do
            let!(:space_travel) { create(:space_travel, status: 'started') }
            let(:fuel_params) do
              {
                space_vehicle: {
                  fuel_days: 0
                }
              }
            end

            it 'syncs current travels and change status to fail' do
              put api_v1_space_vehicle_path(space_travel.space_vehicle), params: fuel_params, headers: { Authorization: "Bearer #{api_token.token}" }

              expect(response.status).to eq(200)
              expect(space_travel.reload.status).to eq('failed')
            end
          end
        end
      end
    end
  end
end
