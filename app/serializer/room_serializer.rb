# frozen_string_literal: true

class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :players_count, :code, :jira_key

  has_many :players
  has_many :tasks
end
