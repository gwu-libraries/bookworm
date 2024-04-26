FactoryBot.define do
  factory :investigation do
    name { Faker::NatoPhoneticAlphabet.code_word }
  end
end