# frozen_string_literal: true

class AddJiraKeyToRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :jira_key, :string
    add_index :rooms, :jira_key, unique: true
    add_index :tasks, :jira_id, unique: true
  end
end
