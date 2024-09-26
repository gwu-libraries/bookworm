# frozen_string_literal: true

class WorksRelatedWorks < ApplicationRecord

  validates :work_id, presence: true
  validates :related_work_id, presence: true

  belongs_to :work, foreign_key: 'work_id', class_name: 'Work'
  belongs_to :related_work, foreign_key: 'related_work_id', class_name: 'Work'

end