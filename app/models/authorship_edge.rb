class AuthorshipEdge < ApplicationRecord
  validates :investigation_id, presence: true
  validates :authorship_connection_id, presence: true
  validates :visible, presence: true

  belongs_to :investigation
  belongs_to :authorship_connection
end
