class AddZeroDefaultsToUsers < ActiveRecord::Migration
	def change
		change_table :users do |t|
			t.change :zuth, :float, :default => 0.0, :null => false
			t.change :reputation, :float, :default => 0.0, :null => false
		end
		change_column :investments, :h, :float, :default => 0.0, :null => false
		
	end
end
