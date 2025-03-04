FactoryBot.define do
  factory :works_ids do
    work_openalex_id {}
    doi {}
    mag { rand(1..100).to_s.rjust(10, "0") }
    pmid { rand(1..100).to_s.rjust(10, "0") }
    pmcid { rand(1..100).to_s.rjust(10, "0") }

    trait :without_validations do 
      to_create{ |i| i.save(validate: false) }
    end
  end
end