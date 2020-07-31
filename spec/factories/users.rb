FactoryBot.define do
  factory :user do
      sequence(:name) {|n| "テスト太郎#{n}"}
      sequence(:email) {|n| "rspectest#{n}@gmail.com"}
      password "11111111"
  end
end
