# frozen_string_literal: true

class CrossrefService
  def self.get_paper_details(doi)
    response = BaseService.crossref_connection.get("/works/#{doi}")

    JSON.parse(response.body, symbolize_names: true)
  end
end
