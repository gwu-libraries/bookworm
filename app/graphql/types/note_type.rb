# frozen_string_literal: true

module Types

  class NoteType < Types::BaseObject
    field :id, ID, null: false
    field :investigation_id, Integer
    field :body_text, String
  end

end