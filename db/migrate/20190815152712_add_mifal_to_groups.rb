class AddMifalToGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups, :mifal, foreign_key: true
  end
end
