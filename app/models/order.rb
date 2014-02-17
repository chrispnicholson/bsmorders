class Order < ActiveRecord::Base
  attr_accessible :ordered_at, :vat
  before_create :create_as_draft
  before_update :check_status_before_update
  before_destroy :cannot_delete_order
  has_many :line_items
  has_many :order_statuses
  
  validates :vat, numericality: {greater_than_or_equal_to: 0.01, less_than_or_equal_to: 99.99}
  validate :ordered_at_cannot_be_in_the_past, :validate_status

  # incomplete - needs to allow for no status or one status (just draft)
  def current_order_status
	most_recent_order_statuses = order_statuses.order(:updated_at).last(2)
	current_order_status = most_recent_order_statuses[0]
  end
  
  # incomplete - needs to allow for no status or one status (just draft)
  def incoming_order_status
	most_recent_order_statuses = order_statuses.order(:updated_at).last(2)
	incoming_order_status = most_recent_order_statuses[1]
  end
  
  protected
  def ordered_at_cannot_be_in_the_past
    if ordered_at.present? && ordered_at < Date.today
      errors.add(:ordered_at, "can't be in the past")
    end
  end
  
  def create_as_draft
	status = Status.create(:status_type => 'DRAFT')
	order_status = build_order_status
	statuses << status
  end
  
  def check_status_before_update
    current_order_status_type = current_order_status.status.status_type
	if current_order_status_type == "DRAFT"
	  return true
	else
	  return false
	end
  end
  
  def validate_status
	# check to see if there's a status update from front-end
	# if there is, find what it is

	new_status_type = incoming_order_status.status.status_type
	case new_status_type
	when "DRAFT"
	  save_as_draft
	when "PLACED"
	  save_as_placed
	when "PAID"
	  save_as_paid
	when "CANCELLED"
	  save_as_cancelled
	end
  end
  
  def save_as_draft
	# will only save as draft if currently draft
	# any other status will invalidate this and status will remain same
	old_status_type = current_order_status.status.status_type
	case old_status_type
	when "DRAFT"
	  return
	when "PLACED"
	  errors.add(:statuses, "status cannot be rolled back from placed to draft")
	when "PAID"
	  errors.add(:statuses, "status cannot be rolled back from paid to draft")
	when "CANCELLED"
	  errors.add(:statuses, "status cannot be rolled back from cancelled to draft")
	end
  end
  
  def save_as_placed
	# will only save as placed if in draft mode and with 1 or more line items
	old_status_type = current_order_status.status.status_type
	case old_status_type
	when "DRAFT"
	  unless line_items.size > 0 
	    errors.add(:statuses, "status cannot be moved to placed with no line items")
	  end
	when "PLACED"
	  return
	when "PAID"
	  errors.add(:statuses, "status cannot be rolled back from paid to placed")
	when "CANCELLED"
	  errors.add(:statuses, "status cannot be rolled back from cancelled to placed")
	end
  end
  
  def save_as_paid
	# will only save as paid if already in placed mode
	old_status_type = current_order_status.status.status_type
	case old_status_type
	when "DRAFT"
	  errors.add(:statuses, "status cannot be moved to paid from draft")
	when "PLACED"
	  return
	when "PAID"
	  return
	when "CANCELLED"
	  errors.add(:statuses, "status cannot be rolled back from cancelled to paid")
	end
  end
  
  def save_as_cancelled
  	# will only save if reason given
	reason = current_order_status.reason
	if reason.nil? || reason.trim.empty?
	  errors.add(:statuses, "a cancellation status update needs a reason")
	end

	# will only save as cancelled if in draft or placed
	old_status_type = current_status.status_type
	case old_status_type
	when "DRAFT"
	  return
	when "PLACED"
	  return
	when "PAID"
	  errors.add(:statuses, "status cannot be rolled back from paid to cancelled")
	when "CANCELLED"
	  errors.add(:statuses, "status of order already cancelled")
	end
  end
  
  def cannot_delete_order
	return false
  end

end
