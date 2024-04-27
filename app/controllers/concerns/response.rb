module Response
  def investigation_json_response(object, status = :ok)
    render json: InvestigationSerializer.new(object).serialized_response, status: status
  end

  def work_json_response(object, status = :ok)
    render json: WorkSerializer.new(object).serialized_response, status: status
  end

  def key_json_response(object, status = :ok)
    render json: KeySerializer.new(object).serialized_response, status: status
  end
end