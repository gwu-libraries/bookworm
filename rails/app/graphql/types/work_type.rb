# frozen_string_literal: true

module Types
  class WorkType < Types::BaseObject
    field :id, ID, null: false
    field :doi, String
    field :title, String
    field :display_name, String
    field :publication_year, Integer
    field :work_type, String
    field :cited_by_count, Integer
    field :is_retracted, Boolean
    field :is_paratext, Boolean
    field :cited_by_api_url, String
    field :abstract_inverted_index, String
    field :language, String

    field :topics, [Type::TopicType]
    field :authors, [Type::AuthorType]
    field :institutions, [Type::InstitutionType]
    field :works_biblio, [Type::WorksBiblioType]
    field :works_ids, Type::WorksIdsType
    field :works_open_access, Type::WorksOpenAccessType
    field :works_mesh, Type::WorksMeshType
    field :related_works, [Type::WorksType]
    field :referenced_works, [Type::WorksType]
    
    def topics
      object.topics
    end

    def authors
      object.authors
    end

    def institutions
      object.institutions
    end

    def works_biblio
      object.works_biblio
    end

    def works_ids
      object.works_ids
    end

    def works_open_access
      object.works_open_access
    end

    def works_mesh
      object.works_mesh
    end

    def related_works
      object.related_works
    end

    def referenced_works
      object.referenced_work
    end
  end
end
