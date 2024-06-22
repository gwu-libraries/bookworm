# frozen_string_literal: true

module Mutations
  class AddRootWork < BaseMutation
    argument :doi, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::WorkType

    def resolve(**attributes)

      # add step here to check if already in DB here, only make API call to crossref if not
      crossref_work = CrossrefFacade.get_paper_details(attributes[:doi])

      investigation = Investigation.find(attributes[:investigation_id])

      work = investigation.works.create!(doi: crossref_work.doi,
                                        title: crossref_work.title,
                                        root_work: true)

      if work.save
        {
          work: work,
          errors: []
        }
      else
        {
          work: null,
          errors: work.errors.full_messages
        }
      end
    end
  end
end