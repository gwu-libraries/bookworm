# frozen_string_literal: true

module Types
  class EdgeType < BaseObject
    field :id, ID, null: false
    field :visible, Boolean, null: false
    field :connection, Types::ConnectionType

    def connection
      object.connection
    end
  end
end
