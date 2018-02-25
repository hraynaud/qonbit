FactoryBot.define do

  factory :domain  do |f|
    f.sequence(:name) { |n| "subject #{n}" }
  end
end
