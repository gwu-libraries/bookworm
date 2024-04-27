class Key < ApplicationRecord
  validates :site, presence: true
  validates :value, presence: true

  belongs_to :user
end