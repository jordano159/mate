# frozen_string_literal: true

class AddRoleToStaffs < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :role, :integer
  end
end
