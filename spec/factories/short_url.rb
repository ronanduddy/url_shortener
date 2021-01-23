FactoryBot.define do
  factory :short_url do
    sequence(:url) { |n| "http://www.example#{n}.com" }

    user
  end
end
