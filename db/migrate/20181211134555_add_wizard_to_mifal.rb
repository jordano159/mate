class AddWizardToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :wizard, :text
  end
end
