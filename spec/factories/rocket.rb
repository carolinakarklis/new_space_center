FactoryBot.define do
  factory :rocket do
    load_type  { create(:load_type) }
    fuel_days { 10 }
  end
end
