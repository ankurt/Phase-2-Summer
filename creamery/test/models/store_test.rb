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

  # phone
  should allow_value('123-456-7890').for(:phone)
  should allow_value('1231231234').for(:phone)
  should_not allow_value('12312312345').for(:phone)
  should_not allow_value('123 asd 1234').for(:phone)
  should_not allow_value('12-2345-1234').for(:phone)
  should_not allow_value('213-123-213').for(:phone)

  # contexts setup

	context "Creating a store context" do
	    setup do 
	      @store = FactoryGirl.create(:store)
	      @store1 = FactoryGirl.create(:store, name: "Silicon Valley Store")
	      @store2 = FactoryGirl.create(:store, name: "Grand Store")
	      @store3 = FactoryGirl.create(:store, name: "Another Store", active: false)
	      @store4 = FactoryGirl.create(:store, name: "Very Nice Store", active: false)
	      @store5 = FactoryGirl.create(:store, name: "Z Store")
	      @store6 = FactoryGirl.create(:store, name: "A Store")
	      @store7 = FactoryGirl.create(:store, name: "All Attributes", state: 'PA', phone: '609-216-5609', city: 'Philadelphia')
	    end
	    
	    teardown do
	      @store
	      @store1
	      @store2
	      @store3
	      @store4
	      @store5
	      @store6
	      @store7
	    end

	    # testing scopes

	    # alphabetical
	    should "alphabetize names of stores" do
	      assert_equal ['A Store', 'A&B Store', 'All Attributes', 'Another Store', 'Grand Store', 'MyString', 'MyString', 'Silicon Valley Store', 'Very Nice Store', 'Z Store'], Store.alphabetical.map(&:name)
	    end

	    # active
	    should "have a scope to find all active stores" do
	      assert_equal ["A&B Store", "Silicon Valley Store", "Grand Store", "Z Store", "A Store", "All Attributes"], Store.active.map(&:name)
	    end

	    # testing active scope
	    should "have a scope to find all inactive stores" do
	      assert_equal ["MyString", "MyString", "Another Store", "Very Nice Store"], Store.inactive.map(&:name)
	    end

	end


end
