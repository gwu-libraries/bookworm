class InvestigationWork < ApplicationRecord
  validates :investigation_id, presence: true
  validates :work_id, presence: true

  belongs_to :investigation
  belongs_to :work
end