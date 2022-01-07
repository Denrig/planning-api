# frozen_string_literal: true

class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :players_count, :code

  has_many :players
  has_many :tasks
end
