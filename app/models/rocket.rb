class Rocket < ApplicationRecord
  belongs_to :load_type

  has_one :space_vehicle, as: :vehicleable
end
