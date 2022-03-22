# frozen_string_literal: true

class Api::V1::RoomsController < Api::V1::BaseController
  def index
    render json: paginate(Room.all)
  end

  def create
    room = Room.create!(room_params)

    render json: room, include: 'players'
  end

  def show
    render json: room, include: %w[players tasks]
  end

  def destroy
    room.destroy!
    room.broadcast({ type: :ROOM_DELETED })

    head :ok
  end

  private

    def room
      @room ||= Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name, :players_count, :is_active, :jira_key)
    end
end
