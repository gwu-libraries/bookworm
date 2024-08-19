# frozen_string_literal: true

module Types
  class AuthorshipEdgeType < BaseObject
    field :id, ID, null: false
    field :visible, Boolean, null: false

    field :investigation, Types::InvestigationType
    field :authorship_connection, Types::AuthorshipConnectionType
    field :author_node, Types::AuthorNodeType
    field :work_node, Types::WorkNodeType

    def investigation
      object.investigation
    end

    def authorship_connection
      object.authorship_connection
    end

    def author_node
      AuthorNode.find_by(
        investigation_id: object.investigation.id,
        author_id: object.authorship_connection.author.id
      )
    end

    def work_node
      WorkNode.find_by(
        investigation_id: object.investigation.id,
        work_id: object.authorship_connection.work.id
      )
    end
  end
end
