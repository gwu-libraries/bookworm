FactoryBot.define do
  factory :source do
    sequence(:source_openalex_id) { |n| "S#{n.to_s.rjust(10, "0")}" }
    sequence(:issn) { |n| "0000-#{n.to_s.rjust(4, "0")}" }
    sequence(:issn_l) { |n| "0000-#{n.to_s.rjust(4, "0")}" }
    display_name { "#{Faker::Company.name} #{Faker::Company.suffix}" }
    publisher { Faker::Company.name }
    works_count { rand(10..100) }
    cited_by_count { rand(10..100) }
    is_oa { [true, false].sample }
    is_in_doaj { [true, false].sample }
    homepage_url { Faker::Internet.url(host: "example.com") }

    after :create do |source|
      create(:sources_ids,
             :without_validations,
             source_openalex_id: source.source_openalex_id)

      5.times do
        create(:sources_counts_by_year,
               :without_validations,
               source_openalex_id: source.source_openalex_id)
      end
    end

    factory :oa_source do
      is_oa { true }
    end
  end
end