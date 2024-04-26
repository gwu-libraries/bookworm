module Response
  def investigation_json_response(object, status = :ok)
    render json: InvestigationSerializer.new(object).serialized_response, status: status
  end
end