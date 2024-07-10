# frozen_string_literal: true

class CrossrefWork
  attr_reader :reference_count,
              :publisher,
              :funders,
              :doi,
              :type,
              :pages,
              :source,
              :is_referenced_by_count,
              :title,
              :volume,
              :authors,
              :language,
              :url,
              :references

  def initialize(data)
    @references = data[:message][:reference] || []

    @reference_count = data[:'reference-count'] || []

    @publisher = data[:publisher] || []

    @funders = data[:message][:funder].map { |funder| funder[:name] } || []

    @doi = data[:message][:DOI] || []

    @type = data[:message][:type] || []

    @pages = data[:message][:page] || []

    @source = data[:message][:source] || []

    @is_referenced_by_count = data[:message][:'is-referenced-by-count'] || []

    @title = data[:message][:title].first || []

    @volume = data[:message][:volume] || []

    @authors =
      data[:message][:author].map do |author|
        "#{author[:family]}, #{author[:given]}"
      end || []

    @language = data[:message][:language] || []

    @url = data[:message][:URL] || []
  end
end
