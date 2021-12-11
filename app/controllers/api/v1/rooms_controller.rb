class Api::V1::RoomsController < Api::V1::BaseController
  def create
    room = Room.create(room_params)

    render json: room
  end

  private

    def room_params
      params.require(:room).permit(:name, :players_count, :is_active)
    end
end
