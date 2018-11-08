# frozen_string_literal: true

class AddCommentsToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :comments, :text
  end
end
