# frozen_string_literal: true

FactoryBot.define do
  factory :work do
    investigation_id {}
    doi { Faker::Archival.doi }
    title { Faker::Book.title }
  end
end
