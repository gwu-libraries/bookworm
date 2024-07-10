# frozen_string_literal: true

module Mutations
  class AddCitations < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::WorkType

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      root_work = Work.find_by(openalex_id: attributes[:openalex_id])

      openalex_citations =
        OpenalexFacade.get_paper_citations(attributes[:openalex_id])

      created_citations = []
      openalex_citations.each do |citation|
        created_citations << Work.find_or_create_by(
          doi: citation.doi,
          title: citation.title,
          language: citation.language,
          openalex_id: citation.openalex_id,
          publication_year: citation.publication_year,
          keywords: citation.keywords,
          topics: citation.topics
        )
      end

      created_citations.map do |citation|
        Connection.find_or_create_by(
          citation_id: citation.id,
          reference_id: root_work.id
        )
      end

      MutationResult.call(
        obj: {
          object: created_citations
        },
        success: created_citations.all?(&:save),
        errors: 'uhoh'
      )
    end
  end
end
