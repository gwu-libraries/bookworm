class SemanticScholarWork
  attr_reader :paper_id,
              :title,
              :doi,
              :reference_count,
              :citation_count

  def initialize(data)
    @paper_id = data[:paperId]
    @title = data[:title]
    @doi = data[:externalIds][:DOI]
    @reference_count = data[:referenceCount]
    @citation_count = data[:citationCount]
  end
end
