# frozen_string_literal: true

module Types
  class WorkEdgeType < BaseObject
    field :id, ID, null: false
    field :visible, Boolean, null: false
    field :investigation, Types::InvestigationType
    field :connection, Types::ConnectionType
    field :citation, Types::WorkType
    field :reference, Types::WorkType
    field :citation_node, Types::WorkNodeType
    field :reference_node, Types::WorkNodeType

    def connection
      object.connection
    end

    def investigation
      object.investigation
    end

    def citation
      object.connection.citation
    end

    def reference
      object.connection.reference
    end

    def citation_node
      WorkNode.find_by(
        investigation_id: object.investigation_id,
        work_id: object.connection.citation.id
      )
    end

    def reference_node
      WorkNode.find_by(
        investigation_id: object.investigation_id,
        work_id: object.connection.reference.id
      )
    end
  end
end
