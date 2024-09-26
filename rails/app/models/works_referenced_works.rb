# frozen_string_literal: true

class WorksReferencedWorks < ApplicationRecord

  validates :work_id, presence: true
  validates :referenced_work_id, presence: true

  belongs_to :work, foreign_key: 'work_id', class_name: 'Work'
  belongs_to :referenced_work, foreign_key: 'referenced_work_id', class_name: 'Work'

end