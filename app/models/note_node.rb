# frozen_string_literal: true

class NoteNode < ApplicationRecord
  validates :visible, presence: true

  belongs_to :investigation
end
