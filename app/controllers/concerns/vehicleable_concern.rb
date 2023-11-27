module VehicleableConcern
  extend ActiveSupport::Concern

  def create_vehicleable
    return create_rocket if space_vehicle_params[:rocket_attributes]
    return create_space_bus if space_vehicle_params[:space_bus_attributes]
    return create_alien_ship if space_vehicle_params[:alien_ship_attributes]
  end

  def update_vehicleable
    update_fuel if update_params[:fuel_days]

    @vehicle.update(update_params.except(:fuel_days)) && @vehicle.vehicleable.save
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

  def update_fuel
    @vehicle.vehicleable.fuel_days = update_params[:fuel_days]

    travels = SpaceTravel.in_course_for_vehicle(@vehicle.id)

    travels.each do |travel|
      next if @vehicle.vehicleable.fuel_days >= travel.duration_in_days

      travel.fail!
    end
  end
end
