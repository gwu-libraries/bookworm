FactoryBot.define do
  factory :authors_ids do
    author_openalex_id {}
    orcid {}
    scopus {}
    twitter { Faker::Internet.url(host: "example.com") }
    wikipedia { Faker::Internet.url(host: "example.com") }

    # not sure why this is needed, but unable to create associations with validations
    trait :without_validations do 
      to_create{ |i| i.save(validate: false) }
    end
  end
end