FactoryBot.define do
  factory :publishers_counts_by_year do
    publisher_openalex_id {}
    sequence(:year) { |n| n + 1980 }
    works_count { rand(1..20) }
    cited_by_count { rand(1..20) }
    oa_works_count {rand(1..20) }

    trait :without_validations do
      to_create{ |i| i.save(validate: false) }
    end
  end
end