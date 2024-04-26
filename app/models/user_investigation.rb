class UserInvestigation < ApplicationRecord
  validates :user_id, presence: true
  validates :investigation_id, presence: true

  belongs_to :user
  belongs_to :investigation
end