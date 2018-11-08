# frozen_string_literal: true

class AddGroupAssociationToHead < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :head_id, :integer
  end
end
