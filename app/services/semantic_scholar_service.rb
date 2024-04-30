# frozen_string_literal: true

class SemanticScholarService
  def self.default_params
    { "fields":
      %i[paperId corpusId url title
         venue publicationVenue year
         authors externalIds
         referenceCount citationCount
         influentialCitationCount isOpenAccess
         openAccessPdf fieldsOfStudy s2FieldsOfStudy
         publicationTypes publicationDate journal
         citationStyles].join(',') }
  end

  # probably move this to a helper module
  def self.citation_calls_required(citation_count)
    return 1 if citation_count <= 1000
    return citation_count.round(-3) / 1000 if (citation_count % 1000).zero?

    citation_count.round(-3) / 1000 + 1
  end

  def self.get_paper_details(paper_id)
    response = BaseService.semantic_scholar_connection.get("/graph/v1/paper/#{paper_id}",
                                                           default_params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_paper_citations(paper_id)
    # semantic scholar's api can return up to 1000 results at a time
    # if a paper has more than 1000 results, this calculates the number of api calls needed to get all of the results
    # and uses the number of calls needed to set the offset for each call
    required_call_count = citation_calls_required(SemanticScholarFacade.get_paper_details(paper_id).citation_count)

    response_arr = []
    required_call_count.times do |index|
      response = BaseService.semantic_scholar_connection.get("/graph/v1/paper/#{paper_id}/citations",
                                                             default_params.merge({ "limit": 1000 },
                                                                                  { "offset": index * 1000 }))
      json_response = JSON.parse(
        response.body, symbolize_names: true
      )

      json_response[:data].each do |paper_data|
        response_arr << paper_data
      end

      sleep 2
    end

    response_arr.flatten
  end
end
