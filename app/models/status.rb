class Status < ActiveRecord::Base
  attr_accessible :order_status_id, :status_reason, :status_type
  belongs_to :order_status
end
