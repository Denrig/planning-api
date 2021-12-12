# frozen_string_literal: true

class RoomAttendance < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum role: {
    player: 100,
    spectator: 101,
    admin: 102
  }
end
