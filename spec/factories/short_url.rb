FactoryBot.define do
  factory :short_url do
    sequence(:url) { |n| "http://www.example#{n}.com" } 
    slug { SecureRandom.uuid[0..7] }
    views { 0 }

    user
  end
end
