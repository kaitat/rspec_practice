FactoryBot.define do
  factory :review do
    title {'とてもよい！'}
    body {'おもしろかった'}
    evaluation {4}
    association :book
    association :user
  end
end
