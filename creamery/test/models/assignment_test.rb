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
          @store1 = FactoryGirl.create(:store, name: "Silicon Valley Store")
          @store2 = FactoryGirl.create(:store, name: "Grand Store")
          @store3 = FactoryGirl.create(:store, name: "Another Store", active: false)
          @store4 = FactoryGirl.create(:store, name: "Very Nice Store", active: false)
          @store5 = FactoryGirl.create(:store, name: "Z Store")
          @store6 = FactoryGirl.create(:store, name: "A Store")
          @employee1 = FactoryGirl.create(:employee)
          @employee2 = FactoryGirl.create(:employee)
          @employee3 = FactoryGirl.create(:employee)
          @employee4 = FactoryGirl.create(:employee)
          @employee5 = FactoryGirl.create(:employee)
          @employee6 = FactoryGirl.create(:employee)
          @assignment = FactoryGirl.create(:assignment)
          @assignment2 = FactoryGirl.create(:assignment, store_id: @store1.id, employee_id: @employee1.id, start_date: "20/01/2000", end_date: "15/02/2002", pay_level: 3)
          @assignment3 = FactoryGirl.create(:assignment, store_id: @store2.id, employee_id: @employee2.id, start_date: "20/08/1999", pay_level: 4)
          @assignment4 = FactoryGirl.create(:assignment, store_id: @store3.id, employee_id: @employee3.id, start_date: "20/01/1998", pay_level: 4)
          @assignment5 = FactoryGirl.create(:assignment, store_id: @store4.id, employee_id: @employee4.id, end_date: "10/05/2017", pay_level: 4)
          @assignment6 = FactoryGirl.create(:assignment, store_id: @store4.id, employee_id: @employee4.id, start_date: "25/01/2020", pay_level: 6 )
          @assignment7 = FactoryGirl.create(:assignment, store_id: @store6.id, employee_id: @employee6.id)
          @assignment8 = FactoryGirl.create(:assignment, store_id: @store5.id, employee_id: @employee6.id, start_date: "27/01/2017")
        end
        
        teardown do
          @store1
          @store2
          @store3
          @store4
          @store5
          @store6
          @employee1
          @employee2
          @employee3
          @employee4
          @employee5
          @employee6
          @assignment
          @assignment2
          @assignment3
          @assignment4
          @assignment5
          @assignment6
          @assignment7
          @assignment8
        end

        # testing scopes

        should "test current scope" do
          assert_equal [1, 3, 4, 6, 8], Assignment.current.map(&:id)
        end

        should "test for_store scope" do
          assert_equal [5, 6], Assignment.for_store(@store4.id).map(&:id)
        end

        should "test for_employee scope" do
          assert_equal [5, 6], Assignment.for_employee(@employee4.id).map(&:id)
        end

        should "test for_pay_level scope" do
          assert_equal [3,4,5], Assignment.for_pay_level(4).map(&:id)
        end

        should "test by_pay_level scope" do
            assert_equal [1, 7, 8, 2, 3, 4, 5, 6], Assignment.by_pay_level.map(&:id)
        end

        should "test by_store scope" do
            assert_equal [2, 3, 4, 5, 6, 8, 7, 1], Assignment.by_store.map(&:id)
        end

        # regulars
        should "test end previous assignments method" do
            assert_equal "27/01/2017", Assignment.find(@assignment7.id).end_date.strftime('%d/%m/%Y')
        end

    end

end
