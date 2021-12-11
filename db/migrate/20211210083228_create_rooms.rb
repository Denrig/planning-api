class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extensions.include?('pgcrypto')
    enable_extension 'uuid-ossp' unless extensions.include?('uuid-ossp')

    create_table :rooms, id: :uuid do |t|
      t.string :name
      t.integer :players_count
      t.boolean :active, default: true
      t.boolean :is_private, default: false

      t.timestamps
    end
  end
end
