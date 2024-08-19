# frozen_string_literal: true

class BaseService
  def self.openalex_connection
    Faraday.new(url: 'https://api.openalex.org') do |faraday|
      faraday.headers['mailto'] = ENV['openalex_mailto']
    end
  end
end
