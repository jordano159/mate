# frozen_string_literal: true

class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :name
      t.belongs_to :staffable, polymorphic: true

      t.timestamps
    end
    add_index :staffs, %i[staffable_id staffable_type]
  end
end
