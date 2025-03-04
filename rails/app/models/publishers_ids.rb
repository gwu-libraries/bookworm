# frozen_string_literal: true

class PublishersIds < ApplicationRecord
  belongs_to :publisher,
             primary_key: :publisher_openalex_id,
             foreign_key: :publisher_openalex_id
end
