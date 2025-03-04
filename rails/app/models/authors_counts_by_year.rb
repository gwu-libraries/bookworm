# frozen_string_literal: true

class AuthorsCountsByYear < ApplicationRecord
  belongs_to :author,
             primary_key: :author_openalex_id,
             foreign_key: :author_openalex_id
end
