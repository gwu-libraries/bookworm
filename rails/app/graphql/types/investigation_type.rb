# frozen_string_literal: true

module Types
  class InvestigationType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer
    field :name, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :note_nodes, [Types::NoteNodeType], null: true
    field :author_nodes, [Types::AuthorNodeType], null: true
    field :work_nodes, [Types::WorkNodeType], null: true

    field :work_edges, [Types::WorkEdgeType], null: true
    field :authorship_edges, [Types::AuthorshipEdgeType], null: true

    def note_nodes
      object.note_nodes
    end

    def author_nodes
      object.author_nodes
    end

    def work_nodes
      object.work_nodes
    end

    def work_edges
      object.work_edges
    end

    def authorship_edges
      object.authorship_edges
    end

    # def citation_edges
    #   object.citation_edges
    # end

    # def reference_edges
    #   object.reference_edges
    # end

    # def authorship_edges
    #   object.authorship_edges
    # end
  end
end
