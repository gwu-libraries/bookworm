FactoryBot.define do
  factory :topic do
    sequence(:topic_openalex_id) { |n| "T#{n.to_s.rjust(5, "0")}" }
    display_name { Faker::Color.color_name.titleize }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    keywords {["dogs", "cats", "frogs", "horses"].sample(2) }
    wikipedia_id { Faker::Internet.url(host: "example.com") }
  end
end