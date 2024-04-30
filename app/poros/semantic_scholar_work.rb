# frozen_string_literal: true

class SemanticScholarWork
  attr_reader :paper_id,
              :title,
              :doi,
              :reference_count,
              :citation_count

  def initialize(data)
    @paper_id = data[:paperId] if data[:paperId]
    @title = data[:title] if data[:title]
    @doi = data[:externalIds][:DOI] if data[:externalIds]
    @reference_count = data[:referenceCount] if data[:referenceCount]
    @citation_count = data[:citationCount] if data[:citationCount]
  end
end
