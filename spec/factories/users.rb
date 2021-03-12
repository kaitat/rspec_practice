FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "TESTRSPEC#{n}@example.com" }
    nick_name { "test user" }
    password { "password" }
  end
end
