class AddUrlNameToTags < ActiveRecord::Migration
  def up
    add_column :tags, :url_name, :string

    Tag.all.each do |t|
    	t.url_name = t.name.downcase.sub " ", "_"
    	t.save
    end

    add_index :tags, :url_name, :unique => true
  end
  def down 
  	remove_column :tags, :url_name
  end
end
