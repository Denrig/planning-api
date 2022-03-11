class AddIsCurrentToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :is_current, :boolean, null: false, default: false
  end
end
