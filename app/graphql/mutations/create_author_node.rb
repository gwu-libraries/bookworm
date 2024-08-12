# frozen_string_literal: true

module Mutations
  class CreateAuthorNode < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, String, required: true

    type Types::AuthorNodeType

    def resolve(**attributes)
      authorize_user

      openalex_author =
        OpenalexFacade.get_author_details(attributes[:openalex_id])

      author =
        Author.find_or_create_by(
          name: openalex_author.display_name,
          orcid: openalex_author.orcid,
          openalex_id: openalex_author.openalex_id
        )

      investigation = Investigation.find(attributes[:investigation_id])

      author_node =
        AuthorNode.find_or_create_by(
          author_id: author.id,
          investigation_id: investigation.id
        )

      author_node.x_coordinate = rand(1000) if author_node.x_coordinate.nil?
      author_node.y_coordinate = rand(1000) if author_node.y_coordinate.nil?

      author_node.save

      author_node.persisted? ? author_node : 'uhoh'
    end
  end
end
