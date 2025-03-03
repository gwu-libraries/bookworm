FactoryBot.define do
  factory :works_open_access do
    work_openalex_id {}
    is_oa { [true, false].sample }
    oa_url { Faker::Internet.url(host: "example.com") }
    oa_status { ['gold', 'silver', 'bronze'].sample }
    any_repository_has_fulltext { [true, false].sample }

    trait :without_validations do
      to_create { |i| i.save(validate: false) }
    end
  end
end