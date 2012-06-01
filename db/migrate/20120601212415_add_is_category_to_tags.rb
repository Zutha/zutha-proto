class AddIsCategoryToTags < ActiveRecord::Migration
  def change
    add_column :tags, :is_category, :boolean

  end
end
