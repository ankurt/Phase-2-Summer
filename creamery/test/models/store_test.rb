require 'test_helper'

class StoreTest < ActiveSupport::TestCase

  # testing relationships
  should have_many(:assignments)

  # testing validations

  # name
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive

  # zip
  should validate_presence_of(:zip)
  should validate_numericality_of(:zip)
  should allow_value('12312').for(:zip)
  should_not allow_value('asd123').for(:zip)
  should_not allow_value('123123123').for(:zip)
  should_not allow_value(nil).for(:zip)
  should_not allow_value("").for(:zip)

  # city
  should validate_presence_of(:city)

  # state
  should allow_value('PA').for(:state)
  should allow_value('OH').for(:state)
  should allow_value('WV').for(:state)
  should_not allow_value('NJ').for(:state)
  should_not allow_value('').for(:state)
  should allow_value(nil).for(:state)



end
