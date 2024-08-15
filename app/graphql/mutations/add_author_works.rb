# frozen_string_literal: true

module Mutations
  class AddAuthorWorks < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, String, required: true

    type [Types::WorkNodeType]

    def resolve(**attributes)
      authorize_user

      author = Author.find_or_create_by(openalex_id: attributes[:openalex_id])

      investigation = Investigation.find(attributes[:investigation_id])

      author_works = OpenalexFacade.get_author_works(attributes[:openalex_id])

      author_node =
        AuthorNode.find_by(
          investigation_id: investigation.id,
          author_id: author.id
        )

      work_nodes = []
      works = []

      author_works.each_with_index do |openalex_work, index|
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

        circle_coordinates =
          circle_point(
            center_x = author_node.x_coordinate,
            center_y = author_node.y_coordinate,
            radius = 500,
            degrees = index * author_works.length
          )

        work_node =
          WorkNode.find_or_create_by(
            investigation_id: investigation.id,
            work_id: work.id
          )

        work_node.x_coordinate =
          circle_coordinates.first unless work_node.x_coordinate.present?

        work_node.y_coordinate =
          circle_coordinates.last unless work_node.y_coordinate.present?

        work_node.visible = true

        work_node.save

        authorship_connection =
          AuthorshipConnection.find_or_create_by(
            author_id: author.id,
            work_id: work.id
          )

        authorship_edge =
          AuthorshipEdge.find_or_create_by(
            authorship_connection_id: authorship_connection.id,
            investigation_id: investigation.id
          )

        works << work
        work_nodes << work_node
      end

      work_nodes
    end
  end
end
