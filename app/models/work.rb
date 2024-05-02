# frozen_string_literal: true

class Work < ApplicationRecord
  validates :doi, presence: true
  validates :title, presence: true
  validates :investigation_id, presence: true

  belongs_to :investigation

  # reference_connections "names" the Connection join table for accessing through the reference association
  has_many :reference_connections, foreign_key: :citation_id, class_name: 'Connection'
  # source: :reference matches with the belong_to :reference identification in the Connection model
  has_many :references, through: :reference_connections, source: :reference

  # citation_connections "names" the Connection join table for accessing through the citation association
  has_many :citation_connections, foreign_key: :reference_id, class_name: 'Connection'

  # source: :citation matches with the belong_to :citation identification in the Connection model
  has_many :citations, through: :citation_connections, source: :citation

  def add_citation(work_id)
    citations << Work.find(work_id)
  end

  def add_reference(work_id)
    references << Work.find(work_id)
  end

  def root_work?
    root_work
  end

  def citation_reference_tree_json
    {
      "name": title,
      "children": [
        {
          "name": 'citations',
          "children": citations.map { |citation| { "name": citation.title } }
        },
        {
          "name": 'references',
          "children": references.map { |citation| { "name": citation.title } }
        }
      ]
    }
  end
end
