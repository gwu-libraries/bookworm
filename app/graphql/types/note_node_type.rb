# frozen_string_literal: true

module Types
  class NoteNodeType < Types::BaseObject
    field :id, Integer
    field :x_coordinate, Integer
    field :y_coordinate, Integer
    field :visible, Boolean, null: false

    field :body_text, String
  end
end
