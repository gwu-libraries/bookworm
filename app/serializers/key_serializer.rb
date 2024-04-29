# frozen_string_literal: true

class KeySerializer
  def initialize(keys_object)
    @keys = [keys_object].flatten
  end

  def key_data(key)
    {
      "id": key.id,
      "user_id": key.user_id,
      "site": key.site,
      "value": key.value
    }
  end

  def serialized_response
    result = { "data": [] }
    @keys.each do |key|
      result[:data] << key_data(key)
    end
    result
  end
end
