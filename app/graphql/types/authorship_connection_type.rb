# frozen_string_literal: true

module Types
  class AuthorshipConnectionType < BaseObject
    field :id, ID, null: false
    field :author, Types::AuthorType
    field :work, Types::WorkType

    def author
      object.author
    end

    def work
      object.work
    end
  end
end
