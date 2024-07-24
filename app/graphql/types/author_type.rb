# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :openalex_id, String
    field :orcid, String
    field :visible, Boolean, null: false
    field :x_coordinate, Integer
    field :y_coordinate, Integer

    field :works, [Types::WorkType], null: true

    def x_coordinate
      200
    end

    def y_coordinate
      200
    end

    def works
      object.works
    end

    def visible
      true
      # fix it lol
    end
  end
end
