# frozen_string_literal: true

class WorksTopic < ApplicationRecord
  belongs_to :work
  belongs_to :topic
end
