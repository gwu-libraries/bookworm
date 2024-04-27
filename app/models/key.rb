class Key < ApplicationRecord
  validates :site, presence: true
  validates :value, presence: true
  validates :user_id, presence: true

  encrypts :value
  
  belongs_to :user
end