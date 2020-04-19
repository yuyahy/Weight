FactoryBot.define do
  factory :human do
        name {"testman"}
        sequence(:email) { |n| "testman#{n}@example.com"}
        password {"password"}
  end
end
