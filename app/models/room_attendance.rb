# frozen_string_literal: true

class RoomAttendance < ApplicationRecord
  belongs_to :user
  belongs_to :room

  scope :players, -> { where(role: :player) }

  enum role: {
    player: 100,
    spectator: 101
  }
end
