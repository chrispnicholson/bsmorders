require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "status name cannot change to anything but DRAFT, PLACED, PAID OR CANCELLED" do
	status = Status.new(:status_type => 'DRAFT')
    assert status.valid?
	status.status_type = 'PLACED'
	assert status.valid?
	status.status_type = 'PAID'
	assert status.valid?
	status.status_type = 'CANCELLED'
	assert status.valid?
	status.status_type = 'FRED'
	assert status.invalid?
	assert status.errors[:status_type].any?
  end
end
