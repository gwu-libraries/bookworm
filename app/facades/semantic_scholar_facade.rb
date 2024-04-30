# frozen_string_literal: true

class SemanticScholarFacade
  def self.get_paper_details(doi)
    json = SemanticScholarService.get_paper_details(doi)

    SemanticScholarWork.new(json)
  end

  def self.get_paper_references(paper_id)
    paper_data_arr = SemanticScholarService.get_paper_references(paper_id)

    works = []
    paper_data_arr.map do |paper_data|
      works << SemanticScholarWork.new(paper_data)
    end

    works
  end
end
