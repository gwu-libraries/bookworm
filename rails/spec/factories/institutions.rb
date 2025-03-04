FactoryBot.define do
  factory :institution do
    sequence(:institution_openalex_id) { |n| "I#{n.to_s.rjust(10, '0')}" }
    ror { 'https://ror.org/' + Faker::Alphanumeric.alphanumeric(number: 9) }
    display_name { Faker::Space.agency }
    country_code { Faker::Address.country_code }
    institution_type { %w[academic company government].sample }
    homepage_url { Faker::Internet.url(host: 'example.com') }
    image_url { Faker::Internet.url(host: 'example.com') }
    image_thumbnail_url { Faker::Internet.url(host: 'example.com') }
    display_name_acronyms {}
    display_name_alternatives {}
    works_count { rand(10..100) }
    cited_by_count { rand(10..100) }

    after :create do |institution|
      create(
        :institutions_ids,
        :without_validations,
        institution_openalex_id: institution.institution_openalex_id
      )

      create(
        :institutions_geo,
        :without_validations,
        institution_openalex_id: institution.institution_openalex_id
      )

      5.times do
        create(
          :institutions_counts_by_year,
          :without_validations,
          institution_openalex_id: institution.institution_openalex_id
        )
      end
    end
  end
end
