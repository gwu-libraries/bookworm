# frozen_string_literal: true

module Types
  class AuthorsCountsByYearType < Types::BaseObject
    field :id, ID, null: false
    field :year, Integer
    field :works_count, Integer
    field :cited_by_count, Integer
    field :oa_works_count, Integer

    field :author, Types::AuthorType

    def author
      object.author
    end
  end
end
