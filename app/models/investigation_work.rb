class InvestigationWork < ApplicationRecord
  # validates :work_x_coordinate, presence: true
  # validates :work_y_coordinate, presence: true

  belongs_to :investigation
  belongs_to :work
end
