class SpaceTravel < ApplicationRecord
  include AASM

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
end
