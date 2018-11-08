# frozen_string_literal: true

class CreateAxes < ActiveRecord::Migration[5.2]
  def change
    create_table :axes do |t|
      t.string :name

      t.timestamps
    end
  end
end
