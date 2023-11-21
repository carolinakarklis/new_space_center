class SpaceVehicleSerializer
  include JSONAPI::Serializer

  attributes :name, :km_per_hour
  belongs_to :agency
  belongs_to :vehicleable, polymorphic: true

  attribute :travel_count do |object|
    object.space_travels.where(status: :finished).count
  end
end
