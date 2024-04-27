class Key < ApplicationRecord
  validates :site, presence: true
  validates :value, presence: true
  validates :user_id, presence: true

  belongs_to :user
end