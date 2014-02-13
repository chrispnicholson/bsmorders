class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
    add_index :products, :name, :unique => true
  end
end
