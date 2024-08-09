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
    field :edges, [EdgeType], null: true

    # field :citation_edges, [Types::CitationEdgeType], null: true
    # field :reference_edges, [Types::ReferenceEdges], null: true
    # field :authorship_edges, [Types::AuthorshipEdges], null: true

    def note_nodes
      object.note_nodes
    end

    def author_nodes
      object.author_nodes
    end

    def work_nodes
      object.work_nodes
    end

    def edges
      object.edges
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
