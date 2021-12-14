# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :room_attendances, dependent: :destroy
  has_many :users, through: :room_attendances

  validates :name, presence: true
  validates :players_count, presence: true, numericality: { greater_than: 0 }

  scope :active, -> { where(active: true) }

  before_create :set_code

  def create_admin!(user_id)
    room_attendances.create!(user_id: user_id, role: :admin)
  end

  def set_code
    self.code = SecureRandom.hex(6)
  end
end
