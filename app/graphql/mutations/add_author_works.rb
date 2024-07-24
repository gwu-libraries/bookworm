# frozen_string_literal: true

module Mutations
  class AddAuthorWorks < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, Integer, required: true

    type [Types::WorkType]

    def resolve(**attributes)
      authorize_user

      author = Author.find_by(openalex_id: attributes[:openalex_id])

      investigation = Investigation.find(attributes[:investigation_id])

      author_works = OpenalexFacade.get_author_works(attributes[:openalex_id])

      works =
        author_works.each do |openalex_work|
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
        end

      investigation_works =
        works.each do |work|
          WorkNode.find_or_create_by(
            investigation_id: investigation.id,
            work_id: work.id,
            visible: true
          )
        end

      works
    end
  end
end
