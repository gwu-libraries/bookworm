# frozen_string_literal: true

module Mutations
  class AddRootWork < BaseMutation
    argument :doi, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::WorkType

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      openalex_work = OpenalexFacade.get_paper_details(attributes[:doi])

      authors_hash = {}
      openalex_work.authors.each do |author|
        if author[:orcid].present?
          authors_hash[author[:name]] = author[:orcid].split(
            'https://orcid.org/'
          ).last
        else
          authors_hash[author[:name]] = 'ORCID not found'
        end
      end

      authors = []

      authors_hash.each do |name, orcid|
        authors << Author.find_or_create_by(name: name, orcid: orcid)
      end

      work =
        Work.find_or_create_by(
          doi: openalex_work.doi,
          title: openalex_work.title,
          openalex_id: openalex_work.openalex_id,
          language: openalex_work.language,
          publication_year: openalex_work.publication_year,
          keywords: openalex_work.keywords,
          topics: openalex_work.topics
        )

      investigation_work =
        InvestigationWork.create(
          investigation_id: investigation.id,
          work_id: work.id,
          root_work: true
        )

      authors.map do |author|
        AuthorWork.find_or_create_by(author_id: author.id, work_id: work.id)
      end

      work.persisted? ? work : 'uhoh'
      # MutationResult.call(
      #   obj: { object: work },
      #   success: work.persisted?,
      #   errors: work.errors.full_messages
      # )
    end
  end
end
