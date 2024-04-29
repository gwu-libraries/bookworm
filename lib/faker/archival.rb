# frozen_string_literal: true

module Faker
  class Archival < Faker::Base
    flexible :archival

    class << self
      def doi
        "10.#{rand(1000..9999)}/#{(0...8).map { rand(65..90).chr }.join}"
      end
    end
  end
end
