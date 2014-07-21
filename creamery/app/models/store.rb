class Store < ActiveRecord::Base
	has_many :assignments

	# validations
  	validates_presence_of :name, :city, :zip
    validates_numericality_of :zip
    validates_length_of :zip, :is => 5
	validates_inclusion_of :state, in: %w[PA OH WV], message: "is not an accepted state"
	validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  	validates_uniqueness_of :name, { case_sensitive: false }

  	# scopes
	scope :alphabetical, -> { order('name') }
	scope :active, -> { where(active: true) }
	scope :inactive, -> { where(active: false) }

end
