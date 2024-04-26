FactoryBot.define do
  factory :key do
    site { Faker::Internet.domain_name }
    value { Faker::Internet.device_token }
  end
end