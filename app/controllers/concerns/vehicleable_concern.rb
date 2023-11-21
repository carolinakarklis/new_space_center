module VehicleableConcern
  extend ActiveSupport::Concern

  def create_vehicleable
    return create_rocket if space_vehicle_params[:rocket_attributes]
    return create_space_bus if space_vehicle_params[:space_bus_attributes]
    return create_alien_ship if space_vehicle_params[:alien_ship_attributes]
  end

  private

  def create_rocket
    load_type = LoadType.create!(
      name: space_vehicle_params[:rocket_attributes][:load_type_name],
      weight: space_vehicle_params[:rocket_attributes][:load_type_weight],
      description: space_vehicle_params[:rocket_attributes][:load_type_description]
    )

    Rocket.create!(
      fuel_days: space_vehicle_params[:rocket_attributes][:fuel_days],
      load_type: load_type
    )
  end

  def create_space_bus
    SpaceBus.create!(
      max_crew: space_vehicle_params[:space_bus_attributes][:max_crew],
      fuel_days: space_vehicle_params[:space_bus_attributes][:fuel_days]
    )
  end

  def create_alien_ship
    AlienShip.create!(
      max_crew: space_vehicle_params[:alien_ship_attributes][:max_crew],
      abductions_number: space_vehicle_params[:alien_ship_attributes][:abductions_number]
    )
  end
end
