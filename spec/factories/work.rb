FactoryBot.define do
  factory :work do
    doi { Faker::Archival.doi }
    title { Faker::Book.title }
  end
end