# frozen_string_literal: true

# == Schema Information
#
# Table name: room_attendances
#
#  id         :bigint           not null, primary key
#  role       :integer
#  room_id    :uuid
#  user_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class RoomAttendance < ApplicationRecord
  belongs_to :user
  belongs_to :room

  scope :players, -> { where(role: :player) }

  enum role: {
    player: 100,
    spectator: 101
  }
end
