# frozen_string_literal: true

FactoryBot.define do
  factory :investigation do
    user_id {}
    name { Faker::NatoPhoneticAlphabet.code_word }
  end
end
