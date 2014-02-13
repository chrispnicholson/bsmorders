class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :order_status_id
      t.string :status_type
      t.string :status_reason

      t.timestamps
    end
  end
end
