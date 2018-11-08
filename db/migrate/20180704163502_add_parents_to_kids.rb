# frozen_string_literal: true

class AddParentsToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :parents, :boolean
  end
end
