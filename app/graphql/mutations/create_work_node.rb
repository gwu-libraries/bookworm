# frozen_string_literal: true

module Mutations
  class CreateWorkNode < BaseMutation
    argument :doi, String, required: true
    argument :investigation_id, String, required: true

    type 'Types::WorkNodeType'

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      openalex_work = OpenalexFacade.get_paper_details(attributes[:doi])

      authors_list = []
      openalex_work.authors.each do |author|
        author_hash = {}

        author[:name].present? ?
          author_hash['name'] = author[:name] :
          'Name missing'

        author[:openalex_id].present? ?
          author_hash['openalex_id'] = author[:openalex_id].split('/').last :
          'OpenAlex ID not found'

        author[:orcid].present? ?
          author_hash['orcid'] = author[:orcid].split('/').last :
          'Orcid not found'

        authors_list << author_hash
      end

      authors = []

      # TODO - fix below
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

      work_node =
        WorkNode.find_or_create_by(
          investigation_id: investigation.id.to_s,
          work_id: work.id
        )

      work_node.x_coordinate = rand(1000) unless work_node.x_coordinate.present?
      work_node.y_coordinate = rand(1000) unless work_node.y_coordinate.present?
      work_node.visible = true

      work_node.save

      authors.map do |author|
        AuthorshipConnection.find_or_create_by(
          author_id: author.id,
          work_id: work.id
        )
      end

      work_node.persisted? ? work_node : 'no'
    end
  end
end
