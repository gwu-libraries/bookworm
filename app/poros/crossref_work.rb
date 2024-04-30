# frozen_string_literal: true

class CrossrefWork
  attr_reader :reference_count,
              :title,
              :doi

  def initialize(data)
    @reference_count = data[:message][:"reference-count"] if data[:message][:"reference-count"]
    @title = data[:message][:title].first if data[:message][:title].first
    @doi = data[:message][:DOI] if data[:message][:DOI]
  end
end
