# frozen_string_literal: true

FactoryBot.define do
  factory :work do
    doi { (0...8).map { (65 + rand(26)).chr }.join } ##this is just a random string
    title { Faker::Book.title }
    language { 'en' }
    publication_year { 2000 }
    keywords { %w[these are keywords] }
    topics { %w[beef a roni] }
  end
end
