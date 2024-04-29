# frozen_string_literal: true

class WorkSerializer
  def initialize(works_object)
    @works = [works_object].flatten
  end

  def work_data(work)
    {
      "id": work.id,
      "investigation_id": work.investigation_id,
      "title": work.title,
      "doi": work.doi
    }
  end

  def serialized_response
    result = { "data": [] }
    @works.each do |work|
      result[:data] << work_data(work)
    end
    result
  end
end
