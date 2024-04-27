class WorkSerializer

  def initialize(work_object)
    @work = work_object
  end

  def serialized_response
    {
      "data": {
        "id": @work.id,
        "title": @work.title,
        "doi": @work.doi
      }
    }
  end
end