require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase

  # test relationships
  should belong_to(:employee)
  should belong_to(:store)

  # test validations
  # store_id
  should validate_presence_of(:store_id)
  should validate_numericality_of(:store_id)
  should_not allow_value(1.4).for(:store_id)
  should_not allow_value(-1).for(:store_id)

  # employee_id
  should validate_presence_of(:employee_id)
  should validate_numericality_of(:employee_id)
  should_not allow_value(1.4).for(:employee_id)
  should_not allow_value(-1).for(:employee_id)

  # start_date
  should validate_presence_of(:start_date)

  # pay_level
  should validate_presence_of(:pay_level)
  should validate_numericality_of(:pay_level)
  should allow_value(1).for(:pay_level)
  should allow_value(6).for(:pay_level)
  should_not allow_value(7).for(:pay_level)
  should_not allow_value(-1).for(:pay_level)
  should_not allow_value(4.5).for(:pay_level)

 # contexts setup

    context "Creating a store context" do
        setup do 
          @assignment = FactoryGirl.create(:assignment)
          @assignment1 = FactoryGirl.create(:assignment, last_name: "Anita", date_of_birth: "20/01/1990", role: 'manager')
          @assignment2 = FactoryGirl.create(:assignment, last_name: "Grand Store", date_of_birth: "20/01/2000", role: 'manager')
          @assignment3 = FactoryGirl.create(:assignment, last_name: "Another Store", date_of_birth: "20/08/1999", role: 'admin', active: false)
          @assignment4 = FactoryGirl.create(:assignment, last_name: "Very Nice Store", active: false, role: 'admin', date_of_birth: "20/01/1998")
          @assignment5 = FactoryGirl.create(:assignment, last_name: "Z Store")
          @assignment6 = FactoryGirl.create(:assignment, last_name: "A Store")
          @assignment7 = FactoryGirl.create(:assignment, last_name: "All Attributes", phone: '609-216-5609')
        end
        
        teardown do
          @assignment
          @assignment1
          @assignment2
          @assignment3
          @assignment4
          @assignment5
          @assignment6
          @assignment7
        end

        # testing scopes

        # alphabetical
        should "alphabetize names of stores" do
          assert_equal ["A Store", "All Attributes", "Anita", "Another Store", "Grand Store", "Toshniwal", "Very Nice Store", "Z Store"], Employee.alphabetical.map(&:last_name)
        end

        # active
        should "have a scope to find all active stores" do
          assert_equal ["Toshniwal", "Anita", "Grand Store", "Z Store", "A Store", "All Attributes"], Employee.active.map(&:last_name)
        end

        # inactive
        should "have a scope to find all inactive stores" do
          assert_equal ["Another Store", "Very Nice Store"], Employee.inactive.map(&:last_name)
        end

        should "reformat phone numbers" do
            assert_equal "1112223334", Employee.first.phone(&:phone)
        end

        # younger_than_18
        should "test younger_than_18 scope" do
            assert_equal ["Grand Store", "Another Store", "Very Nice Store"], Employee.younger_than_18.map(&:last_name)
        end

        # # 18 or older
        should "test 18 or older scope" do
            assert_equal ["Toshniwal", "Anita", "Z Store", "A Store", "All Attributes"], Employee.eighteen_or_older.map(&:last_name)
        end

        # regulars
        should "test regulars scope" do
            assert_equal ['A Store', 'All Attributes', 'Toshniwal', 'Z Store'], Employee.regulars.alphabetical.map(&:last_name)
        end

        # admins
        should "test managers scope" do
            assert_equal ['Another Store', 'Very Nice Store'], Employee.admins.alphabetical.map(&:last_name)
        end

        # managers
        should "test admins scope" do
            assert_equal ['Anita', 'Grand Store'], Employee.managers.alphabetical.map(&:last_name)
        end

        # # current assignment
        # should "" do
        #     assert_equal
        # end

        # age
        should "test age method" do
            assert_equal 20, Employee.find(@employee).age
        end

        # over 18
        should "test over_18 method" do
            assert_equal true, Employee.find(@employee).over_18?
            assert_equal false, Employee.find(@employee2).over_18?
        end

        # reformat ssn
        should "reformat ssn before saving into database" do
            assert_equal "111121234", Employee.find(@employee).ssn
        end






    end

end
