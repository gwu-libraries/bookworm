FactoryBot.define do
  title = Faker::Book.title

  factory :work do
    sequence(:work_openalex_id) { |n| "W#{n.to_s.rjust(10, "0")}" }
    sequence(:doi) { |n| "https://doi.org/#{n}"}
    title { title }
    display_name { title }
    publication_year { rand(1990..2020) }
    publication_date { nil }
    work_type { ['article', 'dataset', 'book'].sample }
    cited_by_count { rand(10..20) }
    is_retracted { false }
    is_paratext { false }
    language { ['en', 'sp', 'jp'].sample }

    factory :retracted_work do
      is_retracted { true }
    end

    factory :paratext_work do
      is_paratext { true }
    end

    factory :article do
      work_type { "article"}
    end

    factory :dataset do
      work_type { "dataset"}
    end

    factory :book do
      work_type { "book"}
    end
  end
end