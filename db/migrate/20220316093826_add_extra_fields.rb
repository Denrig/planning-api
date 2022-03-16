class AddExtraFields < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :description, :text
    add_column :tasks, :status, :string
    add_column :tasks, :issue_type, :integer
  end
end
