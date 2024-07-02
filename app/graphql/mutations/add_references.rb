# frozen_string_literal: true

module Mutations
  class AddReferences < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::WorkType

    def resolve(**attributes)
      authorize_user
      
      investigation = Investigation.find(attributes[:investigation_id])

      root_work = Work.find(investigation.investigation_works.where("root_work": true).first.id)

      openalex_references = OpenalexFacade.get_paper_references(attributes[:openalex_id])

      created_references = []
      openalex_references.each do |reference|
        created_references << root_work.references.create!(doi: reference.doi,
                                                           title: reference.title,
                                                           language: reference.language,
                                                           openalex_id: reference.openalex_id,
                                                           publication_year: reference.publication_year,
                                                           keywords: reference.keywords,
                                                           topics: reference.topics)
      end

      if created_references.all?(&:save)
        {
          references: created_references,
          errors: []
        }
      else
        {
          references: null,
          errors: 'uhoh'
        }
      end
    end
  end
end
