class AddNameIndexToTagTypes < ActiveRecord::Migration
  def change
    add_index :tag_types, :name, :unique => true

  end
end
