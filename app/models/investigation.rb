# frozen_string_literal: true

class Investigation < ApplicationRecord
  validates :name, presence: true

  has_many :work_nodes
  has_many :works, through: :work_nodes

  has_many :author_nodes
  has_many :authors, through: :author_nodes

  has_many :note_nodes

  has_many :work_edges
  has_many :connections, through: :work_edges

  has_many :authorship_edges
  has_many :authorship_connections, through: :authorship_edges

  belongs_to :user
end
