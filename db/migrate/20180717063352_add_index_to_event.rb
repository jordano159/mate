# frozen_string_literal: true

class AddIndexToEvent < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :content
  end
end
