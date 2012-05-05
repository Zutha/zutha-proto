class AddWorthToItem < ActiveRecord::Migration
  def change
  	add_column :items, :worth, 				:float,	:default => 0
    add_column :items, :pos_market_height, 	:float,	:default => 0

  end
end
