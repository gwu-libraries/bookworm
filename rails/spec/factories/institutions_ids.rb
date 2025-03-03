FactoryBot.define do
  factory :institutions_ids do
    institution_openalex_id {}
    ror { rand(1..100).to_s.rjust(10, "0") }
    grid { rand(1..100).to_s.rjust(10, "0") }
    wikipedia { Faker::Internet.url(host: "example.com") }
    wikidata { Faker::Internet.url(host: "example.com") }
    mag { rand(1..100).to_s.rjust(10, "0") }

    trait :without_validations do 
      to_create{ |i| i.save(validate: false) }
    end
  end
end