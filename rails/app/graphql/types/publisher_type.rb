# frozen_string_literal: true

module Types
  class PublisherType < Types::BaseObject
    field :id, ID, null: false
    field :display_name, String
    field :alternate_titles, String
    field :country_codes, String
    field :hierarchy_level, Integer
    field :parent_publisher, String
    field :works_count, Integer
    field :cited_by_count, Integer
    field :sources_api_url, String

    field :publishers_ids, Types::PublishersIdsType
    field :publishers_counts_by_year, Types::PublishersCountsByYearType

    def publishers_ids
      object.publishers_ids
    end

    def publishers_counts_by_year
      object.publishers_counts_by_year
    end
  end
end
