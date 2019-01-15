class AddMifalRefToBuses < ActiveRecord::Migration[5.2]
  def change
    add_reference :buses, :mifal, foreign_key: true
  end
end
