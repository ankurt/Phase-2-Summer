class Employee < ActiveRecord::Base
	# include CreameryFormattingHelpers

	before_save :reformat_phone
    before_save :reformat_ssn

	has_many :assignments
	has_many :stores, through: :assignments

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :ssn, presence: true, format: {with: /\A(\d{9}|\d{3}-?\d{2}-?\d{4})\z/}
    validates :date_of_birth, presence: true, :timeliness => {:on_or_before => lambda { Date.current }, :type => :date}
	validates :role, presence: true, inclusion: { in: %w[employee manager admin]}
	validates :phone, format: {with: /\A(\d{10}|\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"}

    # scopes
    scope :alphabetical, -> { order('last_name, first_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :younger_than_18, -> { where('date_of_birth > ?', 18.years.ago)}
    scope :eighteen_or_older, ->{ where('date_of_birth <= ?', 18.years.ago)}
    scope :regulars, ->{where(role: 'employee')}
    scope :managers, -> {where(role:'manager')}
    scope :admins, -> {where(role:'admin')}

    def name
      name = "#{Employee.find(self.last_name)}, #{Employee.find(self.first_name)}"
    end

    def current_assignment
        return Assignments.where('employee_id = ?',:id).current
    end

    def age
      return nil if date_of_birth.blank?
      (Time.now.to_s(:number).to_i - date_of_birth.to_time.to_s(:number).to_i)/10e9.to_i
    end

    def over_18?
      return true if self.age > 18 else return false
    end

    private

	def reformat_phone
      self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
    end

    def reformat_ssn
      self.ssn = self.ssn.to_s.gsub(/[^0-9]/,"")
    end
	
end
