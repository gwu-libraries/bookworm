# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :investigation
end
