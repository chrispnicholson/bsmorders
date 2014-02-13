class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :ordered_at
      t.decimal :vat, :precision => 4, :scale => 2, :default => 20.00

      t.timestamps
    end
  end
end
