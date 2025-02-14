# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    sequence(:orcid) { |n| "0000-0000-0000-#{n.to_s.rjust(4, "0")}"}
    sequence(:author_openalex_id) { |n| "A#{n.to_s.rjust(10, "0")}"}
    cited_by_count { rand(1..20) }
    works_count { rand(1..20) }
    display_name { Faker::Name.name }
    last_known_institution { Faker::Space.agency }
  end
end
