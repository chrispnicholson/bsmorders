class Status < ActiveRecord::Base
  STATUS_TYPE_STATES = ['DRAFT', 'PLACED', 'PAID', 'CANCELLED']
  attr_accessible :status_reason, :status_type
  belongs_to :order_status
  validates :status_type, :inclusion => STATUS_TYPE_STATES
end
