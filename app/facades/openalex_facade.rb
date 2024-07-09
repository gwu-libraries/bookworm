# frozen_string_literal: true

class OpenalexFacade
  def self.get_paper_details(doi)
    json = OpenalexService.get_paper_details(doi)

    OpenalexWork.new(json)
  end

  def self.get_paper_references(openalex_id)
    references_data = OpenalexService.get_paper_references(openalex_id)

    openalex_references = []

    references_data.each do |reference_arr|
      openalex_references << reference_arr[:results].map {|reference_data| OpenalexReference.new(reference_data)}
    end

    openalex_references.flatten
  end

  def self.get_paper_citations(openalex_id)
    citations_data = OpenalexService.get_paper_citations(openalex_id)

    openalex_citations = []

    citations_data.each do |citation_arr|
      openalex_citations << citation_arr[:results].map {|citation_data| OpenalexCitation.new(citation_data)}
    end
  
    openalex_citations.flatten
  end

  def self.get_author_details(openalex_id)
    author_data = OpenalexService.get_author_details(openalex_id)

    OpenalexAuthor.new(author_data)
  end

end