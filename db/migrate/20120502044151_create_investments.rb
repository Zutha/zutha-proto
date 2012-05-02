class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.float :h
      t.references :user
      t.references :item

      t.timestamps
    end
    add_index :investments, :user_id
    add_index :investments, :item_id
  end
end
