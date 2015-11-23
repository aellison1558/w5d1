FactoryGirl.define do
  factory :goal do
    user_id 1
    body { Faker::Company.bs }
    private false
    completed false

    factory :better_person do
      body "Be a Better Person"
    end

  end

end
