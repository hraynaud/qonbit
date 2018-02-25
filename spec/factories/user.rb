FactoryBot.define do

  factory :user  do |f|
    trait :with_auth_tokens do
      after(:build) do |user, evaluator|
        user.user_oauth_tokens.build(token: "12345", secret: "secret", provider: "oauth")
      end
    end

    factory :valid_user do
      with_auth_tokens
    end
  end
end
