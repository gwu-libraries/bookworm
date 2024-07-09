# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :orcid, String

    field :works, [Types::WorkType], null: true
  end
end