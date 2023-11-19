agency = Agency.create(name: 'TVA')

venus = Planet.create(name: 'Venus', km_from_earth: 900)

load_type = LoadType.create(name: 'satellite', weight: 30)

rocket = Rocket.create(fuel_days: 20, load_type: load_type)

space_vehicle = SpaceVehicle.create(
  vehicleable_id: rocket.id,
  vehicleable_type: 'Rocket',
  name: 'Big Rocket 2.0',
  agency: agency,
  km_per_hour: 100
)