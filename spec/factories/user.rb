FactoryBot.define do

  factory :user  do |f|
    f.sequence(:first_name) { |n| "foo#{n}" }
    f.sequence(:last_name) { |n| "bar#{n}" }
  end
end
