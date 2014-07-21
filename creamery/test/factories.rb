FactoryGirl.define do
  # factory blueprint for curriculum
  factory :store do
    name "A&B Store"
    city "Monroe"
    zip "08831"
    phone "609-216-5609"
    active true
  end

 #  # factory blueprint for camp
 #  factory :camp do
 #  	association :curriculum
 #    curriculum_id 1
 #    cost 0
 #    start_date Date.today
 #    time_slot "AM"
 #    active true
 #  end

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