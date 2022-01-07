# frozen_string_literal: true

class User < ApplicationRecord
  has_many :room_attendances, dependent: :destroy
  has_many :rooms, through: :room_attendances
  has_many :votes, dependent: :destroy

  validates :name, presence: true
end
