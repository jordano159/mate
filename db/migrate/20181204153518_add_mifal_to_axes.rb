class AddMifalToAxes < ActiveRecord::Migration[5.2]
  def change
    add_reference :axes, :mifal, foreign_key: true
  end
end
