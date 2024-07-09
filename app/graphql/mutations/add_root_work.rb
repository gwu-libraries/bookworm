# frozen_string_literal: true

module Mutations
  class AddRootWork < BaseMutation
    argument :doi, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::WorkType

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      if Work.find_by(doi: attributes[:doi].downcase).present?
        work = Work.find_by(doi: attributes[:doi].downcase)
        # maybe handle works added over a certain length of time ago?
      else
        openalex_work = OpenalexFacade.get_paper_details(attributes[:doi])

        work = Work.create(doi: openalex_work.doi,
                           title: openalex_work.title,
                           openalex_id: openalex_work.openalex_id,
                           language: openalex_work.language,
                           publication_year: openalex_work.publication_year,
                           keywords: openalex_work.keywords,
                           topics: openalex_work.topics)
        
        investigation_work = InvestigationWork.create(investigation_id: investigation.id,
                                                      work_id: work.id,
                                                      root_work: true)
      end

      if work.persisted?
        work
      else
        "uhoh"
      end
      # MutationResult.call(
      #   obj: { object: work },
      #   success: work.persisted?,
      #   errors: work.errors.full_messages
      # )

    end
  end
end