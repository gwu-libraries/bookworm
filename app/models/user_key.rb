class UserKey < ApplicationRecord

  validates :user_id, presence: true
  validates :key_id, presence: true

  belongs_to :user
  belongs_to :key

end