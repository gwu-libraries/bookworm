# frozen_string_literal: true

module Types
  class NoteNodeType < Types::BaseObject
    field :x_coordinate, Integer
    field :y_coordinate, Integer
    field :visible, Boolean, null: false

    field :body_text, String
  end
end
