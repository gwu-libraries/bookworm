# frozen_string_literal: true

FactoryBot.define do
  factory :work do
    doi { Faker::Archival.doi }
    title { Faker::Book.title }
    root_work { false }
  end
end
