# frozen_string_literal: true

class WorksTopic < ApplicationRecord
  belongs_to :work,
             primary_key: :work_openalex_id,
             foreign_key: :work_openalex_id

  belongs_to :topic,
             primary_key: :topic_openalex_id,
             foreign_key: :topic_openalex_id
end
