FactoryBot.define do
  factory :group do
    sequence(:name) {|n| "testgroup#{n}"}

    trait :with_two_users do
      after(:build) do |group|
        2.times do |count|
          group.users << FactoryBot.create(:user)
        end
      end
    end

  end

end
