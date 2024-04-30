# frozen_string_literal: true

class CrossrefReference
  attr_reader :key,
              :title,
              :author

  def initialize(data)
    @doi = data[:key] if data[:key]
    @title = data[:"series-title"] if data[:"series-title"]
    @author = data[:author] if data[:author]
  end
end
