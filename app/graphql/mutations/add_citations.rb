# frozen_string_literal: true

module Mutations
  class AddCitations < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::WorkType

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      root_work = Work.find(investigation.investigation_works.where("root_work": true).first.id)

      openalex_citations = OpenalexFacade.get_paper_citations(attributes[:openalex_id])

      created_citations = []
      openalex_citations.each do |citation|
        created_citations << root_work.citations.create!(doi: citation.doi,
                                                         title: citation.title,
                                                         language: citation.language,
                                                         openalex_id: citation.openalex_id,
                                                         publication_year: citation.publication_year,
                                                         keywords: citation.keywords,
                                                         topics: citation.topics)
      end

      if created_citations.all?(&:save)
        {
          citations: created_citations,
          errors: []
        }
      else
        {
          citations: null,
          errors: 'uhoh'
        }
      end
    end
  end
end
