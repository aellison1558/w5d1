FactoryGirl.define do
  factory :user_comment do
    body { Faker::Company.bs }
author_id 1
user_id 1
  end

end
