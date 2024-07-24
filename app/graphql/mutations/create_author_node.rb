# frozen_string_literal: true

module Mutations
  class CreateAuthorNode < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::AuthorType

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

      AuthorNode.find_or_create_by(
        author_id: author.id,
        investigation_id: investigation.id,
        visible: true
      )

      author.persisted? ? author : 'uhoh'
    end
  end
end