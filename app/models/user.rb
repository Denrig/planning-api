class User < ApplicationRecord
  has_many :room_attendances,dependent: :destroy
  has_many :rooms, through: :room_attendances

  validates :name, presence: true

  enum role: {
    player: 100,
    spectator: 101,
    admin: 102
  }
end
