# frozen_string_literal: true

class AddIndexToChecks < ActiveRecord::Migration[5.2]
  def change
    add_index :checks, :name
    add_index :checks, :group_id
    add_index :checks, :approved
  end
end
