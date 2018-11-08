# frozen_string_literal: true

class AddGroupIdToChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :checks, :group_id, :integer
  end
end
