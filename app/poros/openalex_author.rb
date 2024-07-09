# frozen_string_literal: true

class OpenalexAuthor
  attr_reader :openalex_id,
              :orcid,
              :display_name,
              :works_count,
              :cited_by_count,
              :affiliations

  def initialize(data)
    if data[:id]
      @openalex_id = data[:id].split("https://openalex.org/").last
    else
      @openalex_id = []
    end

    if data[:orcid]
      @orcid = data[:orcid].split("https://orcid.org/").last
    else
      @orcid = []
    end

    @display_name = data[:display_name] || []
    @works_count = data[:works_count] || []
    @cited_by_count = data[:cited_by_count] || []

    @affiliations = []

    data[:affiliations].each do |data|
      institution = data[:institution]
      @affiliations << institution[:display_name]
    end

  end
end