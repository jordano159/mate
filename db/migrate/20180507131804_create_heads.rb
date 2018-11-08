# frozen_string_literal: true

class CreateHeads < ActiveRecord::Migration[5.2]
  def change
    create_table :heads do |t|
      t.string :name

      t.timestamps
    end
  end
end
