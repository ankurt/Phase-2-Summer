require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

	should have_many(:assignments)
	should have_many(:stores).through(:assignments)


	# first name
	should validate_presence_of(:first_name)
    should_not allow_value("").for(:first_name)
    should_not allow_value(nil).for(:first_name)

	# last name
	should validate_presence_of(:last_name)

	# ssn
	should validate_presence_of(:ssn)
	should allow_value('123456789').for(:ssn)
	should allow_value('123-45-6789').for(:ssn)
	should_not allow_value('abcdefghi').for(:ssn)
	should_not allow_value('abc-de-fghi').for(:ssn)

  	# phone
	should allow_value('123-456-7890').for(:phone)
	should allow_value('1231231234').for(:phone)
	should allow_value('123 123-1234').for(:phone)
	should allow_value('123 1231234').for(:phone)
	should allow_value('123 456-7890').for(:phone)
	should_not allow_value('12312312345').for(:phone)
	should_not allow_value('123 asd 1234').for(:phone)
	should_not allow_value('12-2345-1234').for(:phone)
	should_not allow_value('213-123-213').for(:phone)

    # date of birth
    should validate_presence_of(:date_of_birth)
    should allow_value('01/01/2001').for(:date_of_birth)
    should allow_value('01-01-2001').for(:date_of_birth)
    should_not allow_value('01-01-2020').for(:date_of_birth)
    should_not allow_value('101-01-2000').for(:date_of_birth)

    # role
    should validate_presence_of(:role)
    should allow_value('employee').for(:role)
    should allow_value('admin').for(:role)
    should allow_value('manager').for(:role)
    should_not allow_value('boss').for(:role)

  # contexts setup

    context "Creating a store context" do
        setup do 
          @employee = FactoryGirl.create(:employee)
          @employee1 = FactoryGirl.create(:employee, last_name: "Anita", date_of_birth: "20/01/1990", role: 'manager')
          @employee2 = FactoryGirl.create(:employee, last_name: "Grand Store", date_of_birth: "20/01/2000", role: 'manager')
          @employee3 = FactoryGirl.create(:employee, last_name: "Another Store", date_of_birth: "20/08/1999", role: 'admin', active: false)
          @employee4 = FactoryGirl.create(:employee, last_name: "Very Nice Store", active: false, role: 'admin', date_of_birth: "20/01/1998")
          @employee5 = FactoryGirl.create(:employee, last_name: "Z Store")
          @employee6 = FactoryGirl.create(:employee, last_name: "A Store")
          @employee7 = FactoryGirl.create(:employee, last_name: "All Attributes", phone: '609-216-5609')
        end
        
        teardown do
          @employee
          @employee1
          @employee2
          @employee3
          @employee4
          @employee5
          @employee6
          @employee7
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
