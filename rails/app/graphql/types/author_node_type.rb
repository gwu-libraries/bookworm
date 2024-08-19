# frozen_string_literal: true

module Types
  class AuthorNodeType < Types::BaseObject
    field :id, Integer
    field :x_coordinate, Integer
    field :y_coordinate, Integer
    field :visible, Boolean, null: false

    field :author, 'Types::AuthorType'

    def author
      object.author
    end
  end
end
