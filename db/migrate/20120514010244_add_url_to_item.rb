class AddUrlToItem < ActiveRecord::Migration
  def change
    add_column :items, :url, :string

  end
end
