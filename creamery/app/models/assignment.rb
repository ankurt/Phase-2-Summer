class Assignment < ActiveRecord::Base
	include FormattingHelpers
	
	belongs_to :employee
	belongs_to :store

end
