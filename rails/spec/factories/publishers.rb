FactoryBot.define do
  factory :publisher do
    sequence(:publisher_openalex_id) { |n| "P#{n.to_s.rjust(10, "0")}" }
    display_name { Faker::Company.name }
    country_codes { Faker::Address.country_code }
    hierarchy_level { rand(0..3) }
    parent_publisher {}
    works_count { rand(10..100) }
    cited_by_count { rand(10..100) }

    after :create do |publisher|
      create(:publishers_ids,
             :without_validations,
             publisher_openalex_id: publisher.publisher_openalex_id)

      5.times do
        create(:publishers_counts_by_year,
              :without_validations,
              publisher_openalex_id: publisher.publisher_openalex_id)
      end
    end
  end
end