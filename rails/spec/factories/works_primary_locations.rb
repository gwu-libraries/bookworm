FactoryBot.define do
  factory :works_primary_location do
    work_openalex_id {}
    source_openalex_id {}
    landing_page_url { Faker::Internet.url(host: "example.com") }
    pdf_url { Faker::Internet.url(host: "example.com") }
    is_oa { [true, false].sample }
    version { rand(1..10) }
    license { ["MIT", "CC"].sample }

    trait :without_validations do
      to_create{ |i| i.save(validate: false )}
    end
  end
end