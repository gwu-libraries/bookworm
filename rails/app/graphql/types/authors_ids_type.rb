# frozen_string_literal: true

module Types
  class AuthorsIdsType < Types::BaseObject
    field :id, ID, null: false
    field :author_id, Integer
    field :openalex, String
    field :orcid, String
    field :scopus, String
    field :twitter, String
    field :wikipedia, String
    field :mag, Integer

    field :author, Types::AuthorType

    def author
      object.author
    end
  end
end
