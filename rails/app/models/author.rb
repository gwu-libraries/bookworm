# frozen_string_literal: true

class Author < ApplicationRecord
  validates :name, presence: true

  has_many :authorship_connections
  has_many :works, through: :authorship_connections

  has_many :author_nodes
  has_many :investigations, through: :author_nodes
end
