# frozen_string_literal: true

class Api::V1::JoinRoomController < Api::V1::BaseController
  def create
    room_attendance = RoomAttendance.find_or_create_by!(room_attendance_params)
    render json: room_attendance
  end

  private

    def room_attendance_params
      params.permit(:user_id, :room_id, :role)
    end
end
