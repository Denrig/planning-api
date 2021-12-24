# frozen_string_literal: true

class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:id])
    stream_for room
  end
end
