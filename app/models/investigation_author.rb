class InvestigationAuthor < ApplicationRecord
  belongs_to :investigation
  belongs_to :author
end
