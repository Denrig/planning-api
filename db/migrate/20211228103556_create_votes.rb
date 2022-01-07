class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :task, foreign_key: true
      t.string :vote

      t.timestamps
    end
  end
end
