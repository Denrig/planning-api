# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :room_attendances, dependent: :destroy
  has_many :users, through: :room_attendances

  validates :name, presence: true
  validates :players_count, presence: true, numericality: { greater_than: 0 }

  scope :active, -> { where(active: true) }

  after_create :create_admin

  private

    def create_admin
      admin = User.new.save(validate: false)
      room_attendances.create!(user: admin, role: :admin)
    end
end
