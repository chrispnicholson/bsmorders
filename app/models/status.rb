class Status < ActiveRecord::Base
  STATUS_TYPE_STATES = ['DRAFT', 'PLACED', 'PAID', 'CANCELLED']
  attr_accessible :status_type
  validates :status_type, :inclusion => STATUS_TYPE_STATES
  has_many :order_status
end
