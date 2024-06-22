# frozen_string_literal: true

class Investigation < ApplicationRecord
  validates :name, presence: true

  has_many :investigation_works
  has_many :works, through: :investigation_works

  belongs_to :user
end
