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
    render json: Room.find(params[:id]), include: %w[players tasks]
  end

  private

    def room_params
      params.require(:room).permit(:name, :players_count, :is_active, :jira_key)
    end
end
