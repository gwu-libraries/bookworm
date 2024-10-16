# frozen_string_literal: true

module Types
  class PublishersIdsType < Types::BaseObject
    field :id, ID, null: false
    field :institution_id, Integer
    field :openalex, String
    field :ror, String
    field :grid, String
    field :wikipedia, String
    field :wikidata, String
    field :mag, Integer

    field :publisher, Types::PublisherType

    def publisher
      object.publisher
    end
  end
end
