# frozen_string_literal: true

module Mutations
  class AddReferences < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, String, required: true

    type [Types::WorkNodeType]

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      root_work = Work.find_by(openalex_id: attributes[:openalex_id])

      root_node =
        root_work.work_nodes.find_by(
          investigation_id: attributes[:investigation_id]
        )

      openalex_references =
        OpenalexFacade.get_paper_references(attributes[:openalex_id])

      created_references = []
      openalex_references.each do |reference|
        created_reference =
          Work.find_or_create_by(
            doi: reference.doi,
            title: reference.title,
            openalex_id: reference.openalex_id,
            language: reference.language,
            publication_year: reference.publication_year,
            keywords: reference.keywords,
            topics: reference.topics,
            is_open_access: reference.is_open_access,
            open_access_url: reference.open_access_url,
            abstract: reference.abstract
          )

        created_references << created_reference

        reference.authors.each do |author_hash|
          author =
            Author.find_or_create_by(
              name: author_hash[:name],
              openalex_id: author_hash[:openalex_id],
              orcid: author_hash[:orcid]
            )

          AuthorshipConnection.find_or_create_by(
            author_id: author.id,
            work_id: created_reference.id
          )
        end
      end

      created_references.map do |reference|
        connection =
          Connection.find_or_create_by(
            citation_id: root_work.id,
            reference_id: reference.id
          )

        WorkEdge.find_or_create_by(
          connection_id: connection.id,
          investigation_id: investigation.id
        )
      end

      work_nodes = []
      created_references.each_with_index do |reference, index|
        work_node =
          WorkNode.find_or_create_by(
            investigation_id: investigation.id.to_s,
            work_id: reference.id
          )

        circle_coordinates =
          circle_point(
            center_x = root_node.x_coordinate,
            center_y = root_node.y_coordinate,
            radius = 1000,
            degrees = 200 + index * (150 / created_references.length)
          )

        work_node.x_coordinate =
          circle_coordinates.first unless work_node.x_coordinate.present?

        work_node.y_coordinate =
          circle_coordinates.last unless work_node.y_coordinate.present?

        work_node.visible = true

        work_node.save

        work_nodes << work_node
      end

      work_nodes
    end
  end
end
