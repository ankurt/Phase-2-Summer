class Assignment < ActiveRecord::Base
	# include CreameryFormattingHelpers
    before_create :end_previous_assignment

	belongs_to :employee
	belongs_to :store

    # validations
    validates :store_id, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
    validates :employee_id, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
    validates :start_date, presence: true, :timeliness => {:type => :date}
    validates :pay_level, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 6 }
    validates :end_date, :timeliness => {:after => :start_date, :type => :date}, allow_nil: true
    
    # scopes
    scope :current, -> {where(end_date: nil)} 
    scope :for_store, ->(store) {where(store_id: store)}
    scope :for_employee, ->(employee) {where(employee_id: employee)}
    scope :for_pay_level, ->(pay_level) {where(pay_level: pay_level)}
    scope :by_pay_level, ->{order('pay_level')}
    scope :by_store, -> {order('store_id')}

    # methods
    def end_previous_assignment
        current = Assignment.for_employee(self.employee_id).current.first
        all = Assignment.for_employee(self.employee_id).first
        if current.nil?
            return
        elsif (self.end_date.nil?) &&  (self.start_date > current.start_date)
            current.end_date = self.start_date.to_s
            current.save
        else
            return
        end

    end


end
