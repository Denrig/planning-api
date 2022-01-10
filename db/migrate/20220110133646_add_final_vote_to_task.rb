# frozen_string_literal: true

class AddFinalVoteToTask < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :is_current
    add_column :tasks, :result, :string
  end
end
