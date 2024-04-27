class Investigation < ApplicationRecord
  validates :name, presence: true

  has_many :works
  belongs_to :user
end