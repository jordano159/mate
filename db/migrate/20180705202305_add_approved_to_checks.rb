# frozen_string_literal: true

class AddApprovedToChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :checks, :approved, :boolean
  end
end
