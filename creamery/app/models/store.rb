class Store < ActiveRecord::Base
	# include CreameryFormattingHelpers

    before_save :reformat_phone

	has_many :assignments
	has_many :employees, through: :assignments

	# validations
  	validates_presence_of :name, :city, :zip
    validates_numericality_of :zip
    validates_length_of :zip, :is => 5
	validates_inclusion_of :state, in: %w[PA OH WV], message: "is not an accepted state", :allow_nil => true
	validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  	validates_uniqueness_of :name, { case_sensitive: false }

  	# scopes
	scope :alphabetical, -> { order('name') }
	scope :active, -> { where(active: true) }
	scope :inactive, -> { where(active: false) }
    
    def reformat_phone
      self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
    end
end
