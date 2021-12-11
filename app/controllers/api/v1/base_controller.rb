# frozen_string_literal: true

class Api::V1::BaseController < ActionController::API
  include ApiErrorHandling

  protected

    def set_current_room
      @current_room = Room.active.find(headers[:room_id])
    end

    def set_current_user
      @current_user = current_room.users.find(headers[:user_id])
    end
end
