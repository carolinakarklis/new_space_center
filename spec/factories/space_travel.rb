FactoryBot.define do
  factory :space_travel do
    start_at { DateTime.new(2023,12,1,10,0,0) }
    duration_in_days { 10 }
    planet { create(:planet) }
    space_vehicle { create(:space_vehicle) }
    mission_description { 'Missão secreta' }
  end
end
