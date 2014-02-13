class CreateOrderStatuses < ActiveRecord::Migration
  def change
    create_table :order_statuses do |t|
      t.integer :order_id
      t.integer :status_id

      t.timestamps
    end
  end
end
