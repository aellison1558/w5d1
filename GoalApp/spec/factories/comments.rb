FactoryGirl.define do
  factory :comment do
    user_id 1
    goal_id 1
    body { Faker::Company.bs }
  end

end
