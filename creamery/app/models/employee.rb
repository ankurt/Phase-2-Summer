class Employee < ActiveRecord::Base
	has_many :assignments
end
