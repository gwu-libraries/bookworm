# frozen_string_literal: true

class Topic < ApplicationRecord
  has_many :works_topics,
           primary_key: :topic_openalex_id,
           foreign_key: :topic_openalex_id

  has_many :works, through: :works_topics
end
