class AddTypeTypeToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tag_type_id, :integer
    remove_column :tags, :is_category
  end
end
