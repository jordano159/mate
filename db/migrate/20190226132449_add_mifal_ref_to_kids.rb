class AddMifalRefToKids < ActiveRecord::Migration[5.2]
  def change
    add_reference :kids, :mifal, foreign_key: true
  end
end
