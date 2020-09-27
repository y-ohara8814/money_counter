FactoryBot.define do
  factory :usage do
    spending_money "1000"
    purpose "hoge"
    date "2020-08-01"
    plan_id "1"
    user_id "1"

    trait :with_user do
      after(:build) do |usage|
          usage.user_id << FactoryBot.create(:user).id
      end
    end

    trait :with_choice1 do
      after(:build) do |usage|
        usage.purpose << FactoryBot.create(:plan).choice1
      end
    end

  end
end
