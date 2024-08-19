# frozen_string_literal: true

module Mutations
  class UpdateWorkNode < BaseMutation
    argument :work_node_id, String, required: true
    argument :x_coordinate, Integer, required: false
    argument :y_coordinate, Integer, required: false
    argument :visible, Boolean, required: false

    type Types::WorkNodeType

    def resolve(**attributes)
      authorize_user

      work_node = WorkNode.find(attributes[:work_node_id])

      update_attributes = attributes.except(:work_node_id)

      work_node.update(update_attributes)

      work_node
    end
  end
end
