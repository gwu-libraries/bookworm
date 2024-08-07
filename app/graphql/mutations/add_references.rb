# frozen_string_literal: true

module Mutations
  class AddReferences < BaseMutation
    argument :openalex_id, String, required: true
    argument :investigation_id, Integer, required: true

    type [Types::WorkNodeType]

    def resolve(**attributes)
      authorize_user

      investigation = Investigation.find(attributes[:investigation_id])

      root_work = Work.find_by(openalex_id: attributes[:openalex_id])

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
            topics: reference.topics
          )

        created_references << created_reference

        reference.authors.each do |author_hash|
          author =
            Author.find_or_create_by(
              name: author_hash[:name],
              openalex_id: author_hash[:openalex_id],
              orcid: author_hash[:orcid]
            )

          AuthorWork.find_or_create_by(
            author_id: author.id,
            work_id: created_reference.id
          )
        end
      end

      created_references.map do |reference|
        Connection.find_or_create_by(
          citation_id: root_work.id,
          reference_id: reference.id
        )
      end

      work_nodes = []
      created_references.each do |reference|
        work_node =
          WorkNode.find_or_create_by(
            investigation_id: investigation.id,
            work_id: reference.id
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
