# frozen_string_literal: true

class CrossrefFacade
  def self.get_paper_details(doi)
    json = CrossrefService.get_paper_details(doi)

    CrossrefWork.new(json)
  end
end
