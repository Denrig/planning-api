class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :character_image, :role
end