class DropFae < ActiveRecord::Migration[5.2]
  def change
    drop_table :fae_changes
    drop_table :fae_files
    drop_table :fae_images
    drop_table :fae_options
    drop_table :fae_roles
    drop_table :fae_static_pages
    drop_table :fae_text_areas
    drop_table :fae_text_fields
    drop_table :fae_users
  end
end
