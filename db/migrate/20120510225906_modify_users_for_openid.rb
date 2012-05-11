class ModifyUsersForOpenid < ActiveRecord::Migration
  def up
  	change_table(:users) do |t|
  		t.remove :username
  		t.rename :fullname, :name
  		t.rename :rpx_identifier, :identifier
  		t.remove_index :email
  		t.index :identifier, :unique => true
  	end

  end

  def down
  end
end
