# frozen_string_literal: true

class AddDefaultValueToCheckApproved < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:checks, :approved, from: nil, to: false)
    change_column_null(:checks, :approved, false, false)
  end
end
