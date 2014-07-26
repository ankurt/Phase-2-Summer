require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

	should have_many(:assignments)
	should have_many(:stores).through(:assignments)


	# first name
	should validate_presence_of(:first_name)

	# last name
	should validate_presence_of(:last_name)

	# ssn
	should validate_presence_of(:ssn)
	should allow_value('123456789').for(:ssn)
	should allow_value('123-45-6789').for(:ssn)
	should_not allow_value('abcdefghi').for(:ssn)
	should_not allow_value('abc-de-fghi').for(:ssn)


end
