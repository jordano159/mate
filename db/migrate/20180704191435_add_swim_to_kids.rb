# frozen_string_literal: true

class AddSwimToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :swim, :string
  end
end
