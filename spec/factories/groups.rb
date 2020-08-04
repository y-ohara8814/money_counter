FactoryBot.define do
  factory :group do
    sequence(:name) {|n| "testgroup#{n}"}

    trait :with_two_users do
      before(:create) do |group|
        2.times do |count|
          group.users << FactoryBot.create(:user)
        end
      end
    end

    trait :name_nil do
      name nil
    end
  end
end
