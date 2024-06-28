# frozen_string_literal: true

class CrossrefService
  def self.get_paper_details(doi)
    response = BaseService.crossref_connection.get("/works/#{doi}")

    JSON.parse(response.body, symbolize_names: true)
  end

  # this method below can go, not useful
  def self.get_paper_references(doi)
    response = BaseService.crossref_connection.get("/works/#{doi}")

    JSON.parse(response.body, symbolize_names: true)[:message][:reference]
  end
end
