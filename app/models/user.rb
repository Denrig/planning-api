# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  name            :string
#  character_image :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_many :room_attendances, dependent: :destroy
  has_many :rooms, through: :room_attendances
  has_many :votes, dependent: :destroy

  validates :name, presence: true
end
