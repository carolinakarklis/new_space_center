FactoryBot.define do
  factory :space_vehicle do
    name { 'Vehicle 2.0' }
    km_per_hour { 100 }
    agency { create(:agency) }
    association :vehicleable, factory: :rocket
  end
end