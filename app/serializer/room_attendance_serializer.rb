# frozen_string_literal: true

class RoomAttendanceSerializer < ActiveModel::Serializer
  attributes :role

  has_one :user
end
