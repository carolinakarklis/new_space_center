class Api::V1::SpaceVehiclesController < Api::V1::BaseController
  include VehicleableConcern

  before_action :set_vehicle, only: [:update, :show]

  def index
    render json: SpaceVehicleSerializer.new(SpaceVehicle.all).serializable_hash
  end

  def show
    render json: SpaceVehicleSerializer.new(@vehicle).serializable_hash
  end

  def create
    vehicleable = create_vehicleable

    vehicle = SpaceVehicle.new(sliced_params.merge!(vehicleable: vehicleable))

    if vehicle.save
      render json: SpaceVehicleSerializer.new(vehicle).serializable_hash
    else
      # implementar caso de erro
    end
  end

  def update
    if update_vehicleable
      render json: SpaceVehicleSerializer.new(@vehicle).serializable_hash
    else
      # implementar caso de erro
    end
  end

  private

  def set_vehicle
    @vehicle = SpaceVehicle.find(params[:id])
  end

  def space_vehicle_params
    params.require(:space_vehicle).permit(
      :name,
      :km_per_hour,
      :agency_id,
      rocket_attributes: [:fuel_days, :load_type_name, :load_type_weight, :load_type_description],
      space_bus_attributes: [:fuel_days, :max_crew],
      alien_ship_attributes: [:abductions_number, :max_crew]
    )
  end

  def update_params
    params.require(:space_vehicle).permit(:name, :km_per_hour, :fuel_days)
  end

  def sliced_params
    space_vehicle_params.slice(:name, :agency_id, :km_per_hour)
  end
end
