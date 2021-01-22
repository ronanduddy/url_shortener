FactoryBot.define do
  factory :short_url do
    url { 'http://www.example.com' }
    slug { '12345678' }
    views { 0 }

    user
  end
end
