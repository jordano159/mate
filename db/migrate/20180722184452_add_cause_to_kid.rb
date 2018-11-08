# frozen_string_literal: true

class AddCauseToKid < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :cause, :text
  end
end
