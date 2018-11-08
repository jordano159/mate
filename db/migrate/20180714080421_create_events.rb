# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.text :content
      t.belongs_to :staff, foreign_key: true
      t.references :eventable, polymorphic: true

      t.timestamps
    end
  end
end
