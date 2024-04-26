class Key < ApplicationRecord
  validates :site, presence: true
  validates :value, presence: true

  has_many :user_keys
  has_many :users, through: :user_keys
end