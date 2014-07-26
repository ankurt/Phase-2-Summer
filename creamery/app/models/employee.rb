class Employee < ActiveRecord::Base
	include FormattingHelpers

	before_save :reformat_phone

	has_many :assignments
	has_many :stores, through: :assignments

	validates :first_names, presence: true
	validates :last_name, presence: true
	validates :ssn, presence: true, format: {with: /\A(\d{9}|\d{3}-?\d{2}-?\d{4})\z/}
	validates :date_of_birth, presence: true
	validates :role, presence: true
	validates :phone, format: {with: /\A(\d{10}|\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"}


end
