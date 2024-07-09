# frozen_string_literal: true

class Investigation < ApplicationRecord
  validates :name, presence: true

  has_many :investigation_works
  has_many :works, through: :investigation_works

  has_many :investigation_authors
  has_many :authors, through: :investigation_authors

  has_many :notes

  belongs_to :user
end
