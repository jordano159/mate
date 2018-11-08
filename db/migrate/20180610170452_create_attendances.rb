# frozen_string_literal: true

class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.integer :kid_id
      t.integer :check_id
      t.integer :status
      t.string :cause

      t.timestamps
    end
  end
end
