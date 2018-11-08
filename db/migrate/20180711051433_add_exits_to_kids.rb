# frozen_string_literal: true

class AddExitsToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :exits, :text
  end
end
