# frozen_string_literal: true

class Work < ApplicationRecord
  validates :doi, presence: true
  validates :title, presence: true

  has_many :work_nodes
  has_many :investigations, through: :work_nodes

  has_many :author_works
  has_many :authors, through: :author_works

  # reference_connections "names" the Connection join table for accessing through the reference association
  has_many :reference_connections,
           foreign_key: :citation_id,
           class_name: 'Connection'
  # source: :reference matches with the belong_to :reference identification in the Connection model
  has_many :references, through: :reference_connections, source: :reference

  # citation_connections "names" the Connection join table for accessing through the citation association
  has_many :citation_connections,
           foreign_key: :reference_id,
           class_name: 'Connection'

  # source: :citation matches with the belong_to :citation identification in the Connection model
  has_many :citations, through: :citation_connections, source: :citation
end
