FactoryBot.define do

  factory :user  do |f|
    f.sequence(:email) { |n| "foo#{n}@example.com" }
    f.sequence(:first_name) { |n| "foo#{n}" }
    f.sequence(:last_name) { |n| "bar#{n}" }
    f.sequence(:handle){|n| "handle #{n+1}" } 
    f.sequence(:uid){|n| n+1 } 
    f.password "foobar"
    f.password_confirmation { |u| u.password }
  end
end
