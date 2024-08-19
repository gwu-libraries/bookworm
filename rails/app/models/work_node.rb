class WorkNode < ApplicationRecord
  validates :visible, presence: true

  belongs_to :investigation
  belongs_to :work
end
