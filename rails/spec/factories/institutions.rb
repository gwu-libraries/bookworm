FactoryBot.define do
  factory :institution do
    sequence(:institution_openalex_id) { |n| "I#{n.to_s.rjust(10, "0")}" }
    sequence(:ror) { |n| "https://ror.org/#{n}"}
    display_name { Faker::Space.agency }
    country_code { Faker::Address.country_code }
    institution_type { ['academic', 'company', 'government'].sample }
    homepage_url { Faker::Internet.url(host: "example.com") }
    image_url { Faker::Internet.url(host: "example.com") }
    image_thumbnail_url { Faker::Internet.url(host: "example.com") }
    display_name_acronyms {}
    display_name_alternatives {}
    works_count { rand(10..100) }
    cited_by_count { rand(10..100) }
  end
end