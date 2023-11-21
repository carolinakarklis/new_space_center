class SpaceTravel < ApplicationRecord
  include AASM

  belongs_to :planet
  belongs_to :space_vehicle

  validates :start_at, presence: true

  validate :enough_vehicle_fuel

  before_validation :calculate_duration_in_days

  enum status: {
    scheduled: 0,
    started: 1,
    aborted: 2,
    failed: 3,
    finished: 4
  }

  aasm column: :status, enum: true do
    state :scheduled, initial: true
    state :started
    state :aborted
    state :failed
    state :finished

    event :start do
      transitions from: :scheduled, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end

    event :abort do
      transitions from: [:scheduled, :started], to: :aborted
    end

    event :fail do
      transitions from: :started, to: :failed
    end
  end

  private

  def calculate_duration_in_days
    duration_in_hours = planet.km_from_earth / space_vehicle.km_per_hour

    self.duration_in_days = (duration_in_hours.to_f / 24).ceil
  end

  def enough_vehicle_fuel
    return if space_vehicle.vehicleable_type == 'AlienShip' || space_vehicle.vehicleable.fuel_days >= duration_in_days

    errors.add(:space_vehicle, "vehicle hasn't enough fuel to schedule travel")
  end
end
