FactoryBot.define do
  factory :user do
    email { "test@example.test" }
    nick_name { "test user" }
    password { "password" }
  end
end
