# frozen_string_literal: true

FactoryBot.define do
  factory :work do
    doi { Faker::Archival.doi }
    title { Faker::Book.title }
    language { "en" }
    publication_year { 2000 }
    keywords { ["these", "are", "keywords"] }
    topics { ["beef", "a", "roni"] }
  end
end
