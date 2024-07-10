# frozen_string_literal: true

class SemanticScholarWork
  attr_reader :paper_id,
              :mag_id,
              :doi,
              :corpus_id,
              :url,
              :title,
              :venue,
              :reference_count,
              :citation_count,
              :topics,
              :publication_date,
              :journal,
              :authors

  def initialize(data)
    @paper_id = data[:paperId] || []

    @mag_id = data[:externalIds][:MAG] || []

    @doi = data[:externalIds][:DOI] || []

    @corpus_id = data[:externalIds][:CorpusId] || []

    @url = data[:url] || []

    @title = data[:title] || []

    @venue = data[:venue] || []

    @year = data[:year] || []

    @reference_count = data[:referenceCount] || []

    @citation_count = data[:citationCount] || []

    @topics =
      data[:fieldsOfStudy] ||
        [] + data[:s2FieldsOfStudy].map { |fos| fos[:category] }.uniq || []

    @publication_date = data[:publicationDate] || []

    @journal = data[:journal][:name] || []

    @authors = data[:authors].map { |a| a[:name] } || []
  end
end
