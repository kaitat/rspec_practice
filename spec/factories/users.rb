FactoryBot.define do
  factory :user do
    # https://github.com/faker-ruby/faker/blob/master/doc/default/internet.md
    password = Faker::Internet.password(8)
    email { Faker::Internet.free_email }
    nick_name { Faker::Internet.username }
    password { password }
    password_confirmation { password }
  end
end
