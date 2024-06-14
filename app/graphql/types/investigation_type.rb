# frozen_string_literal: true

module Types
  class InvestigationType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer
    field :name, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :works, [Types::WorkType], null: true
    field :root_works, [Types::WorkType], null: true

    def root_works
      object.works.where("root_work": true)
    end
  end
end
