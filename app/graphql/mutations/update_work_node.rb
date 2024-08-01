# frozen_string_literal: true

module Mutations
  class UpdateWorkNode < BaseMutation
    argument :work_node_id, Integer, required: true
    argument :x_coordinate, Integer
    argument :y_coordinate, Integer
    argument :visible, Boolean

    type 'Types::WorkNodeType'

    def resolve(**attributes)
      # authorize_user

      work_node = WorkNode.find(attributes[:work_node_id])

      work_node.update(
        x_coordinate: attributes[:x_coordinate],
        y_coordinate: attributes[:y_coordinate],
        visible: attributes[:visible]
      )

      work_node.persisted? ? work_node : 'uhoh'
    end
  end
end
