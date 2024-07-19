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

      authors_list = []

      openalex_work.authors.each do |author|
        author_hash = {}

        if author[:name].present?
          author_hash['name'] = author[:name]
        else
          author_hash['name'] = 'Name missing'
        end

        if author[:openalex_id].present?
          author_hash['openalex_id'] = author[:openalex_id].split(
            'https://openalex.org/'
          ).last
        else
          author_hash['openalex_id'] = 'OpenAlex ID not found'
        end

        if author[:orcid].present?
          author_hash['orcid'] = author[:orcid].split('https://orcid.org/').last
        else
          author_hash['orcid'] = 'ORCID not found'
        end

        authors_list << author_hash
      end

      authors = []
      authors_list.each do |author_hash|
        authors << Author.find_or_create_by(
          name: author_hash['name'],
          openalex_id: author_hash['openalex_id'],
          orcid: author_hash['orcid']
        )
      end

      work =
        Work.find_or_create_by(
          doi: openalex_work.doi,
          title: openalex_work.title,
          openalex_id: openalex_work.openalex_id,
          language: openalex_work.language,
          publication_year: openalex_work.publication_year,
          keywords: openalex_work.keywords,
          topics: openalex_work.topics,
          is_open_access: openalex_work.is_open_access,
          open_access_url: openalex_work.open_access_url
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
