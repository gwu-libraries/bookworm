# frozen_string_literal: true

module Types
  class TopicType < Types::BaseObject
    field :id, ID, null: false
    field :display_name, String
    field :subfield_id, String
    field :subfield_display_name, String
    field :field_id, String,
    field :field_display_name, String
    field :domain_id, String
    field :domain_display_name, String
    field :description, String
    field :keywords, String
    field :works_api_url, String
    field :wikipedia_id, String
    field :works_count, Integer
    field :cited_by_count, Integer

    field :works, [Types::WorkType]

    def works
      object.works
    end
  end
end
