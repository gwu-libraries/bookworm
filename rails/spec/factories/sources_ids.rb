FactoryBot.define do
  factory :sources_ids do
    source_openalex_id {}
    issn { rand(1..100).to_s.rjust(10, "0") }
    issn_l { issn }
    wikidata { Faker::Internet.url(host: "example.com") }
    fatcat { rand(1..100).to_s.rjust(10, "0") }
    mag { rand(1..100).to_s.rjust(10, "0") }

    trait :without_validations do 
      to_create{ |i| i.save(validate: false) }
    end
  end
end