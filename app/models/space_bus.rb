class SpaceBus < ApplicationRecord
  has_one :space_vehicle, as: :vehicleable
end
