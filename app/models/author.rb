# frozen_string_literal: true

class Author < ApplicationRecord

  validates :name, presence: true

  has_many :author_works
  has_many :works, through: :author_works

  has_many :investigation_authors
  has_many :investigations, through: :investigation_authors

end