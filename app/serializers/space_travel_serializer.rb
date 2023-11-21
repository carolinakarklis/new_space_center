class SpaceTravelSerializer
  include JSONAPI::Serializer

  attributes :start_at, :duration_in_days, :mission_description, :status, :planet_id, :space_vehicle_id
end
