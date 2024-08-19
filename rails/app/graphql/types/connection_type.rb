# frozen_string_literal: true

module Types
  class ConnectionType < BaseObject
    field :id, ID, null: false
    field :reference, Types::WorkType
    field :citation, Types::WorkType

    def reference
      object.reference
    end

    def citation
      object.citation
    end
  end
end
