FactoryBot.define do
  
  factory :institutions_geo do
    country_code = Faker::Address.country_code
    
    institution_openalex_id {}
    city { Faker::Address.city }
    geonames_city_id { rand(1..100) }
    region { Faker::Address.time_zone }
    country_code { country_code }
    country { Faker::Address.country_by_code(code: country_code) }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    trait :without_validations do 
      to_create{ |i| i.save(validate: false) }
    end
  end
end