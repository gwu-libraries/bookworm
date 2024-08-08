# frozen_string_literal: true

class Connection < ApplicationRecord
  validates :reference_id, presence: true
  validates :citation_id, presence: true

  belongs_to :reference, foreign_key: 'reference_id', class_name: 'Work'
  belongs_to :citation, foreign_key: 'citation_id', class_name: 'Work'

  has_many :edges
  has_many :investigations, through: :edges
end
