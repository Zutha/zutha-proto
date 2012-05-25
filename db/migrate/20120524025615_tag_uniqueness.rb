class TagUniqueness < ActiveRecord::Migration
  def change
  	change_table :tags do |t|
  		t.change :name, :string, :null => false
  		t.index :name, :unique => true
  	end
  	change_table :tag_links do |t|
  		t.change :tag_id, :integer, :null => false
  		t.change :item_id, :integer, :null => false
  	end
  end
end
