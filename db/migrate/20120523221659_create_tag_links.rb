class CreateTagLinks < ActiveRecord::Migration
  def change
    create_table :tag_links do |t|
      t.references :tag
      t.references :item

      t.timestamps
    end
    add_index :tag_links, :tag_id
    add_index :tag_links, :item_id
  end
end
