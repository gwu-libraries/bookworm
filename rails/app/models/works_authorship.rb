class WorksAuthorship < ApplicationRecord
  belongs_to :author
  belongs_to :work
  belongs_to :institution
end
