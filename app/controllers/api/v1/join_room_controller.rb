# frozen_string_literal: true

class Api::V1::JoinRoomController < Api::V1::BaseController
  def create
    room_attendance = RoomAttendance.find_by(room_attendance_params.except(:role))
    room_attendance = if room_attendance
                        room_attendance.update!(room_attendance_params)
                      else
                        RoomAttendance.create!(room_attendance_params)
                      end

    render json: room_attendance
  end

  def show
    render json: Room.find_by!(code: params[:id])
  end

  private

    def room_attendance_params
      params.permit(:user_id, :room_id, :role)
    end
end
