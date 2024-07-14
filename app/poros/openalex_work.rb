# frozen_string_literal: true

class OpenalexWork
  attr_reader :openalex_id,
              :doi,
              :title,
              :publication_year,
              :language,
              :type,
              :authors,
              :cited_by_count,
              :topics,
              :keywords,
              :grants,
              :referenced_works_count,
              :referenced_works_openalex_ids,
              :datasets,
              :created_date,
              :is_open_access,
              :open_access_url,
              :grants

  def initialize(data)
    @openalex_id =
      data[:ids][:openalex].split('https://openalex.org/').last || []

    if data[:doi]
      @doi = data[:doi].split('https://doi.org/').last
    else
      @doi = []
    end

    @title = data[:title] || []

    @publication_year = data[:publication_year] || []

    @language = data[:language] || []

    @type = data[:type] || []

    @authors =
      data[:authorships].map do |author_data|
        {
          name: author_data[:author][:display_name],
          orcid: author_data[:author][:orcid]
        }
      end || []

    @cited_by_count = data[:cited_by_count] || []

    @topics = data[:topics].map { |topic_data| topic_data[:display_name] } || []

    @keywords =
      data[:keywords].map { |keyword_data| keyword_data[:display_name] } || []

    @grants =
      data[:grants].map do |grant_data|
        {
          funder: grant_data[:funder_display_name],
          award_id: grant_data[:award_id]
        }
      end

    @referenced_works_count = data[:referenced_works_count] || []

    @referenced_works_openalex_ids = data[:referenced_works] || []

    @datasets = data[:datasets] || []

    @created_date = data[:created_date] || []

    @is_open_access = data[:open_access][:is_oa]

    @open_access_url = data[:open_access][:oa_url]

    @grants = data[:grants] || []
  end
end
