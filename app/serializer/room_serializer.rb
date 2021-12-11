class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :players_count

  has_many :users
end
