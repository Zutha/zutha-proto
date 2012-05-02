class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :fullname
      t.float :reputation
      t.float :zuth

      t.timestamps
    end
  end
end
