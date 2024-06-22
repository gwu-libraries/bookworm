# frozen_string_literal: true

class CrossrefWork
  attr_reader :reference_count,
              :publisher,
              :funders,
              :content_domains,
              :published_print,
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
              :issn

  def initialize(data)
    @reference_count = data[:message][:"reference-count"] || nil

    @publisher = data[:message][:publisher] || nil

    if data[:message][:funder]
      @funders = data[:message][:funder].map {|funder| funder[:name]}
    else
      @funders = []
    end

    @content_domains = data[:message][:"content-domain"][:domain] || nil

    @published_print = data[:message][:"published-print"][:"date-parts"] || nil

    @doi = data[:message][:DOI] || nil

    @type = data[:message][:type] || nil

    @pages = data[:message][:page] || nil

    @source = data[:message][:source] || nil

    @is_referenced_by_count = data[:message][:"is-referenced-by-count"] || nil

    @title = data[:message][:title].first || nil

    @volume = data[:message][:volume]

    if data[:message][:author]
      @authors = data[:message][:author].map {|author| "#{author[:family]}, #{author[:given]}"}
    else
      @authors = []
    end

    @language = data[:message][:language] || nil

    @url = data[:message][:URL] || nil

    @issn = data[:message][:ISSN].first || nil
  end
end
