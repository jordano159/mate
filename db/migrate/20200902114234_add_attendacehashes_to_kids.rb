class AddAttendacehashesToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :att_hash, :text
    add_column :kids, :total_att_hash, :text
    add_column :kids, :late_hash, :text
  end
end
