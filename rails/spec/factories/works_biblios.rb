FactoryBot.define do
  factory :works_biblio do
    work_openalex_id {}
    volume { rand(1..10).to_s }
    issue { rand(1..10).to_s }
    first_page { rand(1..10).to_s }
    last_page { (first_page.to_i + rand(1..10)).to_s }

    trait :without_validations do
      to_create{ |i| i.save(validate: false) }
    end
  end
end