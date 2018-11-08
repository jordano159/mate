# frozen_string_literal: true

class AddShabatToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :shabat, :boolean, default: false
  end
end
