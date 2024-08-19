FactoryBot.define do
  factory :user do
    email { Faker::Internet.email(domain: 'gmail.com') }
    password { Faker::Internet.password }
  end
end
