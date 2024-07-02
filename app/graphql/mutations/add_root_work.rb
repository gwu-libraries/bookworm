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
        # crossref_work = CrossrefFacade.get_paper_details(attributes[:doi])

        openalex_work = OpenalexFacade.get_paper_details(attributes[:doi])

        # semanticscholar_work = SemanticScholarFacade.get_paper_details(attributes[:doi])

        # should be able to set what sources you are fetching from

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

        # work = investigation.works.create!(doi: openalex_work.doi,
        #                                   title: openalex_work.title,
        #                                   root_work: true)

        # crossref_references = crossref_work.references.map {|reference_data| CrossrefReference.new(reference_data)}
        
        # crossref_references.each do |reference|
        #   # how do i handle creating reference works that don't have DOIs and/or titles?
        #   if reference[:"article-title"].nil?
        #     work.references.create!(doi: reference[:key],
        #                             title: "Not found")
        #   else
        #     work.references.create!(doi: reference[:key],
        #                             title: reference[:"article-title"])
        #   end
        # end
      end

      if work.save && investigation_work.save
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