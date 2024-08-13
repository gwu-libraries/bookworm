# frozen_string_literal: true

module Types
  class AuthorshipEdgeType < BaseObject
    field :id, ID, null: false
    field :visible, Boolean, null: false

    field :investigation, Types::InvestigationType
    field :authorship_connection, Types::AuthorshipConnectionType

    def investigation
      object.investigation
    end

    def authorship_connection
      object.authorship_connection
    end

    def author
      object.authorship_connection.author
    end

    def author_node
      WorkNode.find_by(
        investigation_id: object.investigation_id,
        work_id: object.authorship_connection.work.id
      )
    end
  end
end
