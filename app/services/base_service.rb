class BaseService

  def self.semantic_scholar_connection
    Faraday.new(url: "https://api.semanticscholar.org") do |faraday|
      faraday.headers['x-api-key'] = ENV['semantic_scholar_key']
    end
  end

  def self.crossref_connection
    Faraday.new(url: "https://api.crossref.org") do |faraday|
      faraday.headers['mailto'] = ENV['crossref_mailto']
    end
  end

end