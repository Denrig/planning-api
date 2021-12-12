# frozen_string_literal: true

class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :players_count

  has_many :room_attendances
end
