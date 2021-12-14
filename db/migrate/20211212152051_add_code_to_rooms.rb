# frozen_string_literal: true

class AddCodeToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :code, :string
    add_index :rooms, :code, unique: true
  end
end
