# frozen_string_literal: true

class Api::V1::JoinRoomController < Api::V1::BaseController
  def create
    room_attendance = RoomAttendance.find_by(room_attendance_params.except(:role))

    if room_attendance
      room_attendance.update!(room_attendance_params)
    else
      room_attendance = RoomAttendance.create!(room_attendance_params)
    end

    notify_players(room_attendance)

    render json: room_attendance
  end

  def destroy
    room_attendance = RoomAttendance.find_by(room_attendance_params.except(:role))

    if room_attendance
      room_attendance.destroy!
      notify_players(room_attendance, :PLAYER_LEFT)
    end

    head :ok
  end

  def show
    render json: Room.find_by!(code: params[:id].downcase)
  end

  private

    def notify_players(room_attendance, type = :PLAYER_JOINED)
      room_attendance.room.broadcast({ type: type,
                                       user: UserSerializer.new(room_attendance.user).serializable_hash,
                                       role: room_attendance.role })
    end

    def room_attendance_params
      params.permit(:user_id, :room_id, :role)
    end
end
