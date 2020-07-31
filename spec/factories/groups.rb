FactoryBot.define do
  factory :group do
    sequence(:name) {|n| "testgroup#{n}"}
    before(:create) do |group|
      user
      user
    end
    user_ids "1,2"
  end
end
