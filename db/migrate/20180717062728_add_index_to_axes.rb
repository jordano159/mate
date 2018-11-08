# frozen_string_literal: true

class AddIndexToAxes < ActiveRecord::Migration[5.2]
  def change
    add_index :axes, :name
  end
end
