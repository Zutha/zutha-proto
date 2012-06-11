class AddUrlNameToTagTypes < ActiveRecord::Migration
  def up
    add_column :tag_types, :url_name, :string
    
    TagType.all.each do |tt|
    	tt.url_name = tt.name.downcase.sub " ", "_"
    	tt.save
    end

    add_index :tag_types, :url_name, :unique => true
  end
  def down
  	remove_column :tag_types, :url_name
  end
end
