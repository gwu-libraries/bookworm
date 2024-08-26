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
              :grants,
              :abstract

  def initialize(data)
    @openalex_id = data[:ids][:openalex].split("/").last || "Not found"

    if data[:doi]
      @doi = data[:doi].split("/").last
    else
      @doi = "Not found"
    end

    if data[:abstract_inverted_index]
      uninverted_arr = []

      data[:abstract_inverted_index].each do |word, placement_arr|
        placement_arr.each do |placement_index|
          uninverted_arr[placement_index] = word.to_s
        end
      end

      @abstract = uninverted_arr.join(" ")
    end

    @title = data[:title] || []

    @publication_year = data[:publication_year] || []

    @language = data[:language] || []

    @type = data[:type] || []

    @authors =
      data[:authorships].map do |author_data|
        {
          name:
            (
              if author_data[:author][:display_name].present?
                author_data[:author][:display_name]
              else
                "Not found"
              end
            ),
          orcid:
            (
              if author_data[:author][:orcid].present?
                author_data[:author][:orcid].split("/").last
              else
                "Not found"
              end
            ),
          openalex_id:
            (
              if author_data[:author][:id].present?
                author_data[:author][:id].split("/").last
              else
                "Not found"
              end
            )
        }
      end

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
