# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :room_attendances, dependent: :destroy
  has_many :users, through: :room_attendances

  has_many :players, lambda {
                       where(room_attendances: { role: :player }).distinct
                     }, through: :room_attendances, class_name: 'User', source: :user

  has_many :tasks, dependent: :destroy

  validates :name, presence: true

  scope :active, -> { where(active: true) }

  before_create :set_code

  def create_admin!(user_id)
    room_attendances.create!(user_id: user_id, role: :admin)
  end

  def set_code
    self.code = SecureRandom.hex(3)
  end

  def broadcast(data)
    RoomChannel.broadcast_to(self, data)
  end
end
