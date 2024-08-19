# frozen_string_literal: true

class OpenalexAuthor
  attr_reader :openalex_id,
              :orcid,
              :display_name,
              :works_count,
              :cited_by_count,
              :affiliations,
              :h_index,
              :i10_index

  def initialize(data)
    if data[:id]
      @openalex_id = data[:id].split("https://openalex.org/").last
    else
      @openalex_id = "Not found"
    end

    if data[:orcid]
      @orcid = data[:orcid].split("https://orcid.org/").last
    else
      @orcid = "Not found"
    end

    @display_name = data[:display_name] || "Not found"
    @works_count = data[:works_count] || "Not found"
    @cited_by_count = data[:cited_by_count] || "Not found"

    @h_index = data[:summary_stats][:h_index]
    @i10_index = data[:summary_stats][:i10_index]
    @affiliations = []

    data[:affiliations].each do |data|
      institution = data[:institution]
      @affiliations << {
        display_name:
          (
            if institution[:display_name].present?
              institution[:display_name]
            else
              "Not found"
            end
          ),
        openalex_id:
          (
            if institution[:id].present?
              institution[:id].split("/").last
            else
              "Not found"
            end
          ),
        type: institution[:type].present? ? institution[:type] : "Not found",
        years: data[:years].present? ? data[:years] : "Not found"
      }
    end
  end
end
