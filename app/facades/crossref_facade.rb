# frozen_string_literal: true

class CrossrefFacade
  def self.get_paper_details(doi)
    json = CrossrefService.get_paper_details(doi)

    CrossrefWork.new(json)
  end

  def self.get_paper_references(doi)
    paper_data_arr = CrossrefService.get_paper_references(doi)

    works = []
    paper_data_arr.map do |paper_data|
      works << CrossrefReference.new(paper_data)
    end

    works
  end
end
