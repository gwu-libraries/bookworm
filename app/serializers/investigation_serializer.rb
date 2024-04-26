class InvestigationSerializer

  def initialize(investigation_object)
    @investigation = investigation_object
  end

  def serialized_response
    {
      "data": {
        "id": @investigation.id,
        "name": @investigation.name
      }
    }
  end
end