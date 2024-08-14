# frozen_string_literal: true

module Mutations
  class CreateAuthorNode < BaseMutation
    argument :author_openalex_id, String, required: true
    argument :work_openalex_id, String, required: true
    argument :investigation_id, String, required: true

    type Types::AuthorNodeType

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      root_work = Work.find_by(openalex_id: attributes[:work_openalex_id])

      root_work_node =
        root_work.work_nodes.find_by(
          investigation_id: attributes[:investigation_id]
        )

      openalex_author =
        OpenalexFacade.get_author_details(attributes[:author_openalex_id])

      author =
        Author.find_or_create_by(
          name: openalex_author.display_name,
          orcid: openalex_author.orcid,
          openalex_id: openalex_author.openalex_id
        )

      authorship_connection =
        AuthorshipConnection.find_or_create_by(
          author_id: author.id,
          work_id: root_work.id
        )

      author_node =
        AuthorNode.find_or_create_by(
          author_id: author.id,
          investigation_id: investigation.id
        )

      AuthorshipEdge.find_or_create_by(
        authorship_connection_id: authorship_connection.id,
        investigation_id: investigation.id
      )

      circle_coordinates =
        circle_point(
          center_x = root_work_node.x_coordinate,
          center_y = root_work_node.y_coordinate,
          radius = 300,
          degrees = rand(0..360) # probably fix to more specific options on left/right of root node
        )

      author_node.x_coordinate =
        circle_coordinates.first if author_node.x_coordinate.nil?

      author_node.y_coordinate =
        circle_coordinates.last if author_node.y_coordinate.nil?

      author_node.save

      author_node.persisted? ? author_node : 'uhoh'
    end
  end
end
