class Assignment < ActiveRecord::Base
	include FormattingHelpers
	
	belongs_to :employees
	belongs_to :stores

end
