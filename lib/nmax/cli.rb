# frozen_string_literal: true

require 'optparse'

module Nmax
  module CLI
    def self.call
      OptionParser.new do |opts|
        opts.banner = 'Usage: cat sample_data_40GB.txt | nmax 10000'
      end.parse!

      input_data = $stdin.gets
      count_numbers = ARGV[0].to_i

      begin
        result = Nmax::SeekerIntegers.new(input_data: input_data, count_numbers: count_numbers).search.join("\n")
        puts result
        result
      rescue Nmax::Error => e
        message = e.message
        puts message
        message
      end
    end
  end
end
