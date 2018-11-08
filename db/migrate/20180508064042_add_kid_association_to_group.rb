# frozen_string_literal: true

class AddKidAssociationToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :group_id, :integer
  end
end
