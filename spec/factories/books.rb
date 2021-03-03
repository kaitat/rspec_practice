FactoryBot.define do
  factory :book do
    id { 1 }
    title { 'プロを目指す人のためのRuby入門' }
    price { 3251 }
    publish_date { '2017-11-25' }
    description { "Ruby" }
    # アソシエーション
    category { create(:category) }
  end
end
