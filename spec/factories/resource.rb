FactoryBot.define do

  factory :resource  do |f|

    trait :with_valid_users do
      association :user, strategy: :build
      association :specialist, factory: :user, strategy: :build
    end

    trait :with_domain do
      association :domain, strategy: :build
    end

    factory :resource_with_self_as_specialist do
      with_valid_users
      with_domain
      after(:build) do |resource,evaluator|
        resource.specialist = resource.user
      end
    end


    trait :complete do
      with_valid_users
      with_domain
    end
  end
end
