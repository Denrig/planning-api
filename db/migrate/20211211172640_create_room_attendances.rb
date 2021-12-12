# frozen_string_literal: true

class CreateRoomAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :room_attendances do |t|
      t.integer :role
      t.references :room, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
