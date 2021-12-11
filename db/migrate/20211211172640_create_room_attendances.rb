class CreateRoomAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :room_attendances do |t|
      t.references :room, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
    
      t.timestamps
    end
  end
end
