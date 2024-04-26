class SemanticScholarService

  def self.default_params
    {"fields": 
      ['paperId', 'corpusId', 'url', 'title', 
      'venue', 'publicationVenue', 'year',
      'authors', 'externalIds', 
      'referenceCount', 'citationCount',
      'influentialCitationCount', 'isOpenAccess',
      'openAccessPdf', 'fieldsOfStudy', 's2FieldsOfStudy',
      'publicationTypes', 'publicationDate', 'journal',
      'citationStyles'
      ].join(",")
    }
  end

  def self.get_paper_details(paper_id)
    response = BaseService.semantic_scholar_connection.get("/graph/v1/paper/#{paper_id}",
                                                            params = self.default_params)
    JSON.parse(response.body, symbolize_names: true)
  end

end