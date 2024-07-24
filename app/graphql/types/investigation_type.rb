# frozen_string_literal: true

module Types
  class InvestigationType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer
    field :name, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :works, [Types::WorkType], null: true
    field :authors, [Types::AuthorType], null: true
    field :notes, [Types::NoteType], null: true

    def works
      object.works
    end

    def authors
      object.authors
    end

    def notes
      object.notes
    end
  end
end
