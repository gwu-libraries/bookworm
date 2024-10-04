# frozen_string_literal: true

class Topic < ApplicationRecord
  has_many :works_topics
  has_many :works, through: :works_topics
end
