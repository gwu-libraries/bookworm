# frozen_string_literal: true

module Mutations
  class AddCites < BaseMutation
    argument :doi, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::WorkType

    def resolve(**attributes)
      # add step here to check if already in DB here, only make API call to crossref if not

      crossref_citations = CrossrefFacade.get_paper_references(attributes[:doi])

      investigation = Investigation.find(attributes[:investigation_id])

      root_work = investigation.works.where("root_work").first

      cites = crossref_citations.each do |citation|
        root_work.citations.create!(doi: citation.doi,
                                    title: citation.title)
      end

      require 'pry'; binding.pry 
      
      if cites.all? save
        {
          cites: cites,
          errors: []
        }
      else
        {
          cites: null,
          errors: "uhoh"
        }
      end
    end
  end
end