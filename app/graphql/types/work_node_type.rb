# frozen_string_literal: true

module Types
  class WorkNodeType < Types::BaseObject
    field :x_coordinate, Integer
    field :y_coordinate, Integer
    field :visible, Boolean, null: false

    field :work, Types::WorkType

    def work
      object.work
    end
  end
end
