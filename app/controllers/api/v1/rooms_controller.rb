# frozen_string_literal: true

class Api::V1::RoomsController < Api::V1::BaseController
  def create
    room = Room.create(room_params)
    room.create_admin!(params[:user_id])

    render json: room, include: 'room_attendances.user'
  end

  def show
    render json: Room.find(params[:id]), include: %w[room_attendances.user tasks]
  end

  private

    def room_params
      params.require(:room).permit(:name, :players_count, :is_active)
    end
end
