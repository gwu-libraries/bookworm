# frozen_string_literal: true

module Mutations
  class AddReferences < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::WorkType

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      root_work = Work.find_by(openalex_id: attributes[:openalex_id])

      openalex_references =
        OpenalexFacade.get_paper_references(attributes[:openalex_id])

      created_references = []

      openalex_references.each do |reference|
        created_references << Work.find_or_create_by(
          doi: reference.doi,
          title: reference.title,
          openalex_id: reference.openalex_id,
          language: reference.language,
          publication_year: reference.publication_year,
          keywords: reference.keywords,
          topics: reference.topics
        )
      end

      created_references.map do |reference|
        Connection.find_or_create_by(
          citation_id: root_work.id,
          reference_id: reference.id
        )
      end

      MutationResult.call(
        obj: {
          object: created_references
        },
        success: created_references.all?(&:save),
        errors: 'uhoh'
      )
      # if created_references.all?(&:save)
      #   created_references # nop
      # else
      #   "uhoh"
      # end
    end
  end
end
