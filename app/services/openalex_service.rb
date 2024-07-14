# frozen_string_literal: true

class OpenalexService
  def self.get_paper_details(doi)
    response =
      BaseService.openalex_connection.get("/works/https://doi.org/#{doi}")

    # if 404, try some other variation?
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_paper_references(openalex_id)
    accumulated_responses = []

    first_response =
      BaseService.openalex_connection.get(
        "/works?filter=cited_by:#{openalex_id}&per-page=200&cursor=*"
      )

    accumulated_responses << JSON.parse(
      first_response.body,
      symbolize_names: true
    )

    until accumulated_responses.last[:meta][:next_cursor].nil?
      new_response =
        BaseService.openalex_connection.get(
          "/works?filter=cited_by:#{openalex_id}&per-page=200&cursor=#{accumulated_responses.last[:meta][:next_cursor]}"
        )

      accumulated_responses << JSON.parse(
        new_response.body,
        symbolize_names: true
      )
    end

    accumulated_responses
  end

  def self.get_paper_citations(openalex_id)
    accumulated_responses = []

    first_response =
      BaseService.openalex_connection.get(
        "/works?filter=cites:#{openalex_id}&per-page=200&cursor=*"
      )

    accumulated_responses << JSON.parse(
      first_response.body,
      symbolize_names: true
    )

    until accumulated_responses.last[:meta][:next_cursor].nil?
      new_response =
        BaseService.openalex_connection.get(
          "/works?filter=cites:#{openalex_id}&per-page=200&cursor=#{accumulated_responses.last[:meta][:next_cursor]}"
        )

      accumulated_responses << JSON.parse(
        new_response.body,
        symbolize_names: true
      )
    end

    accumulated_responses
  end

  def self.get_author_details(openalex_id)
    response = BaseService.openalex_connection.get("/authors/#{openalex_id}")

    JSON.parse(response.body, symbolize_names: true)
  end
end
