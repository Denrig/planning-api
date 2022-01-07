# frozen_string_literal: true

class Api::V1::JoinRoomController < Api::V1::BaseController
  def create
    room_attendance = RoomAttendance.find_by(room_attendance_params.except(:role))

    if room_attendance
      room_attendance.update!(room_attendance_params)
    else
      room_attendance = RoomAttendance.create!(room_attendance_params)
    end

    notify_player_joined(room_attendance) if room_attendance.player?

    render json: room_attendance
  end

  def show
    render json: Room.find_by!(code: params[:id].downcase)
  end

  private

    def notify_player_joined(room_attendance)
      room_attendance.room.broadcast({ type: :PLAYER_JOINED,
                                       user: UserSerializer.new(room_attendance.user).serializable_hash })
    end

    def room_attendance_params
      params.permit(:user_id, :room_id, :role)
    end
end
