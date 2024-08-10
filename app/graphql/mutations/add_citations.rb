# frozen_string_literal: true

module Mutations
  class AddCitations < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, String, required: true

    type [Types::WorkNodeType]

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      root_work = Work.find_by(openalex_id: attributes[:openalex_id])

      openalex_citations =
        OpenalexFacade.get_paper_citations(attributes[:openalex_id])

      created_citations = []
      openalex_citations.each do |citation|
        created_citation =
          Work.find_or_create_by(
            doi: citation.doi,
            title: citation.title,
            language: citation.language,
            openalex_id: citation.openalex_id,
            publication_year: citation.publication_year,
            keywords: citation.keywords,
            topics: citation.topics,
            is_open_access: citation.is_open_access,
            open_access_url: citation.open_access_url
          )

        created_citations << created_citation

        citation.authors.each do |author_hash|
          author =
            Author.find_or_create_by(
              name: author_hash[:name],
              openalex_id: author_hash[:openalex_id],
              orcid: author_hash[:orcid]
            )

          AuthorWork.find_or_create_by(
            author_id: author.id,
            work_id: created_citation.id
          )
        end
      end

      created_citations.map do |citation|
        connection =
          Connection.find_or_create_by(
            citation_id: citation.id,
            reference_id: root_work.id
          )

        WorkEdge.find_or_create_by(
          connection_id: connection.id,
          investigation_id: investigation.id
        )
      end

      work_nodes = []
      created_citations.each do |citation|
        work_node =
          WorkNode.find_or_create_by(
            investigation_id: investigation.id.to_s,
            work_id: citation.id
          )

        work_node.x_coordinate =
          rand(1000) unless work_node.x_coordinate.present?

        work_node.y_coordinate =
          rand(1000) unless work_node.y_coordinate.present?

        work_node.visible = true

        work_node.save

        work_nodes << work_node
      end

      work_nodes
    end
  end
end
