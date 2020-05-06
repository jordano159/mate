class AddMifalToHeads < ActiveRecord::Migration[5.2]
  def change
    add_reference :heads, :mifal, foreign_key: true
  end
end
