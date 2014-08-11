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

 #  # factory blueprint for instructor
 #  factory :instructor do
 #    first_name "Ankur"
 #    last_name "Toshniwal"
 #    phone 1231231234
 #    active true
 #  end

 #  # factory blueprint for camp_instructor
 #  factory :camp_instructor do
 #  	association :instructor
 #  	association :camp
 #  	camp_id 1
 #  	instructor_id 1
 # end

end