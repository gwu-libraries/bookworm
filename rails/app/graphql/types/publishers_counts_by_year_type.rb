# frozen_string_literal: true

module Types
  class PublishersCountsByYearType < Types::BaseObject
    field :id, ID, null: false
    field :year, Integer
    field :works_count, Integer
    field :cited_by_count, Integer
    field :oa_works_count, Integer

    field :publisher, Types::PublisherType

    def publisher
      object.publisher
    end
  end
end
