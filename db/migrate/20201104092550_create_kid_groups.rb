class CreateKidGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :kid_groups do |t|
      t.references :kid, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
