# frozen_string_literal: true

FactoryBot.define do
  factory :investigation do
    user_id {}
    sequence(:name) { |n| "Investigation #{n}" }
  end
end
