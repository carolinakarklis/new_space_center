class Api::V1::SpaceTravelsController < Api::V1::BaseController
  def index
    render json: SpaceTravelSerializer.new(SpaceTravel.all).serializable_hash
  end

  def create
    travel = SpaceTravel.new(space_travel_params)

    if travel.save
      render json: SpaceTravelSerializer.new(travel).serializable_hash
    else
      render json: ErrorSerializer.new(travel).serializable_hash, status: 422
    end
  end

  def update
  end

  def fail
    travel = SpaceTravel.find(params[:space_travel_id])

    travel.fail

    render json: SpaceTravelSerializer.new(travel).serializable_hash
  end

  def abort
    travel = SpaceTravel.find(params[:space_travel_id])

    travel.abort

    render json: SpaceTravelSerializer.new(travel).serializable_hash
  end

  private

  def space_travel_params
    params.require(:space_travel).permit(
      :start_at,
      :planet_id,
      :space_vehicle_id,
      :mission_description
    )
  end
end
