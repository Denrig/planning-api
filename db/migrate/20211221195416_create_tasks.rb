# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :text
      t.boolean :is_current, default: true
      t.references :room, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
