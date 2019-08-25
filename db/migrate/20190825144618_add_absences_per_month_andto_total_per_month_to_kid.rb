class AddAbsencesPerMonthAndtoTotalPerMonthToKid < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :absences_per_month, :text
    add_column :kids, :total_per_month, :text
  end
end
