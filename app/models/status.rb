class Status < ActiveRecord::Base
  attr_accessible :status_reason, :status_type
  belongs_to :order_status
  validates :status_type, :inclusion => { :in => ['DRAFT', 'PLACED', 'PAID', 'CANCELLED'] }
end
