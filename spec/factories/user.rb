FactoryBot.define do
  factory :user do
    email { "#{SecureRandom.uuid}@example.com" }
    password { 'password123' }

    factory :user_with_short_urls do
      transient do
        short_urls_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_list(:short_url, evaluator.short_urls_count, user: user)
      end
    end
  end
end
