class SpaceVehicle < ApplicationRecord
  belongs_to :agency
  belongs_to :vehicleable, polymorphic: true
end
