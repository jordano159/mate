# frozen_string_literal: true

class AddNameIndexToGroups < ActiveRecord::Migration[5.2]
  def change
    add_index :groups, :name
  end
end
