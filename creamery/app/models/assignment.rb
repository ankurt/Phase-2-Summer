class Assignment < ActiveRecord::Base
	belongs_to :employee
	belongs_to :store
end
