class RemoveUnusedDeviseFieldsFromUser < ActiveRecord::Migration
	def up
		change_table(:users) do |t|
			t.remove :encrypted_password
			t.remove :reset_password_token
			t.remove :reset_password_sent_at
		end
	end

	def down
		change_table(:users) do |t|
			## Database authenticatable
			t.string :encrypted_password, :null => true, :default => ""

			## Recoverable
			t.string   :reset_password_token
			t.datetime :reset_password_sent_at
		end
	end
end
