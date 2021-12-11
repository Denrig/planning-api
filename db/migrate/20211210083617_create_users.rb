class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :character_image
      t.integer :role
      t.timestamps
    end
  end
end
