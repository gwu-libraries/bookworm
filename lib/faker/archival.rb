module Faker
  class Archival < Faker::Base
    flexible :archival

    class << self

      def doi
        "10.#{rand(1000..9999)}/#{(0...8).map { (65 + rand(26)).chr }.join}"
      end

    end
  end
end