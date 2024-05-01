# frozen_string_literal: true

class InvestigationSerializer
  def initialize(investigations_object)
    @investigations = [investigations_object].flatten
  end

  def investigation_data(investigation)
    {
      "id": investigation.id,
      "user_id": investigation.user_id,
      "name": investigation.name,
      "created_at": investigation.created_at
    }
  end

  def serialized_response
    result = { "data": [] }
    @investigations.each do |investigation|
      result[:data] << investigation_data(investigation)
    end
    result
  end
end
