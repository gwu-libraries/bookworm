# frozen_string_literal: true

class CrossrefReference
  # this whole thing gotta go

  # get list of references from the Crossref work initial call
  # get the DOIs
  # iterated through and fetch the full data for each
  attr_reader :doi,
              :title,
              :author,
              :key,
              :volume_title,
              :unstructured,
              :series_title,
              :year,
              :doi_asserted_by,
              :volume

  def initialize(data)
    if data[:"doi-asserted-by"]
      @doi_asserted_by = data[:"doi-asserted-by"]
    else
      @doi_asserted_by = nil
    end

    if data[:"journal-title"]
      @journal_title = data[:"journal-title"]
    else
      @journal_title = nil
    end

    if data[:volume]
      @volume = data[:volume]
    else
      @volume = nil
    end

    if data[:DOI]
      @doi = data[:DOI]
    else
      @doi = nil
    end

    if data[:key]
      @key = data[:key]
    else
      @key = nil
    end

    if data[:"volume-title"]
      @volume_title = data[:"volume-title"]
    else
      @volume_title = nil
    end

    if data[:"series-title"]
      @series_title = data[:"series-title"]
    else
      @series_title = nil
    end

    if data[:year]
      @year = data[:year]
    else
      @year = nil
    end

    if data[:unstructured]
      @unstructured = data[:unstructured]
    else
      @unstructured = nil
    end

    if data[:author]
      @author = data[:author]
    else
      @author = nil
    end

  end
end
