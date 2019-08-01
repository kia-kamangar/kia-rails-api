FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "kia#{n}" }
    name { "Kia KMG" }
    url { "http://example.com" }
    avatar_url { "http://example.com/avatar" }
    provider { "github" }
  end
end
