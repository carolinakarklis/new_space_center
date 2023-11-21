class SpaceBusSerializer
  include JSONAPI::Serializer

  attributes :fuel_days, :max_crew
end