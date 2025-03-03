FactoryBot.define do
  factory :publishers_ids do
    publisher_openalex_id {}
    ror { rand(1..100).to_s.rjust(10, "0") }
    wikidata { Faker::Internet.url(host: "example.com") }

    # not sure why this is needed, but unable to create associations with validations
    trait :without_validations do 
      to_create{ |i| i.save(validate: false) }
    end
  end
end