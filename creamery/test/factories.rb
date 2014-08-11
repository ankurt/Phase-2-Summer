FactoryGirl.define do
  # factory blueprint for store
  factory :store do
    name "A&B Store"
    city "Monroe"
    zip "08831"
    phone "609-216-5609"
    active true
  end

  # factory blueprint for employee
  factory :employee do
    first_name 'Ankur'
    last_name 'Toshniwal'
    ssn '111-12-1234'
    phone '111-222-3334'
    role 'employee'
    date_of_birth '27/04/1994'
    active true
  end

  # factory blueprint for assignment
  factory :assignment do
    store_id 1
    employee_id 1
    pay_level 1
    start_date '27/01/2016'
    association :employee
    association :store
  end

end