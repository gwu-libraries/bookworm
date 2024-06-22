# frozen_string_literal: true

class CrossrefReference
  # this whole thing gotta go

  # get list of citations from the Crossref work initial call
  # get the DOIs
  # iterated through and fetch the full data for each
  attr_reader :doi,
              :title,
              :author

  def initialize(data)
    if data[:key]
      @doi = data[:key]
    else
      @doi = "not found"
    end

    if data[:"series-title"]
      @title = data[:"series-title"]
    else
      @title = "not found"
    end

    if data[:author]
      @author = data[:author]
    else
      @author = "not found"
    end
  end
end
