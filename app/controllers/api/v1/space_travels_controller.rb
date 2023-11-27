class Api::V1::SpaceTravelsController < Api::V1::BaseController
  before_action :set_travel, only: [:fail, :abort, :start, :update]

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
    if @travel.update(update_params)
      render json: SpaceTravelSerializer.new(@travel).serializable_hash
    else
      render json: ErrorSerializer.new(@travel).serializable_hash, status: 422
    end
  end

  def fail
    @travel.fail

    render json: SpaceTravelSerializer.new(@travel).serializable_hash
  end

  def abort
    @travel.abort

    render json: SpaceTravelSerializer.new(@travel).serializable_hash
  end

  def start
    @travel.start

    render json: SpaceTravelSerializer.new(@travel).serializable_hash
  end

  private

  def set_travel
    @travel = SpaceTravel.find(params[:space_travel_id] || params[:id])
  end

  def space_travel_params
    params.require(:space_travel).permit(
      :start_at,
      :planet_id,
      :space_vehicle_id,
      :mission_description
    )
  end

  def update_params
    params.require(:space_travel).permit(:start_at, :mission_description)
  end
end
