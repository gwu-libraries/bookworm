class AuthorNode < ApplicationRecord
  validates :visible, presence: true

  belongs_to :investigation
  belongs_to :author
end
