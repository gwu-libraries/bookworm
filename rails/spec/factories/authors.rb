# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    sequence(:orcid) { |n| "0000-0000-0000-#{n.to_s.rjust(4, "0")}"}
    sequence(:author_openalex_id) { |n| "A#{n.to_s.rjust(10, "0")}"}
    cited_by_count { rand(1..20) }
    works_count { rand(1..20) }
    display_name { Faker::Name.name }
    last_known_institution { Faker::Space.agency }

    after :create do |author|
      create(:authors_ids, 
             :without_validations, 
             author_openalex_id: author.author_openalex_id,
             orcid: author.orcid,
             scopus: author.author_openalex_id[1..].to_i.to_s.rjust(10, "0"),
             mag: author.author_openalex_id[1..].to_i.to_s.rjust(10, "0"), # i don't know what a MAG record id looks like
             )

      5.times do
        create(:authors_counts_by_year,
               :without_validations,
               author_openalex_id: author.author_openalex_id)
      end
    end
  end
end
