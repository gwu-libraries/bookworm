# frozen_string_literal: true

module Response
  def investigation_json_response(object, status = :ok)
    render json: InvestigationSerializer.new(object).serialized_response,
           status:
  end

  def work_json_response(object, status = :ok)
    render json: WorkSerializer.new(object).serialized_response, status:
  end
end
