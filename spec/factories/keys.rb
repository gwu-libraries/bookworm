# frozen_string_literal: true

FactoryBot.define do
  factory :key do
    user_id {}
    site { Faker::Internet.domain_name }
    value { Faker::Internet.device_token }
  end
end
