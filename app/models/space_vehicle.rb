class SpaceVehicle < ApplicationRecord
  belongs_to :agency
  belongs_to :vehicleable, polymorphic: true

  has_many :space_travels

  attr_accessor :rocket_attributes, :space_bus_attributes, :alien_ship_attributes
end
