class InvestigationConnection < ApplicationRecord
  validates :investigation_id, presence: true
  validates :connection_id, presence: true

  belongs_to :investigation
  belongs_to :connection
end
