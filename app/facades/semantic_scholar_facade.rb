# frozen_string_literal: true

class SemanticScholarFacade
  def self.get_paper_details(doi)
    json = SemanticScholarService.get_paper_details(doi)

    [json].flatten.map do |paper_data|
      SemanticScholarWork.new(paper_data)
    end
  end
end
