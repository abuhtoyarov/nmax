# frozen_string_literal: true

require 'nmax/version'
require 'nmax/cli'
require 'nmax/errors'

module Nmax
  # Nmax::SeekerIntegers
  #
  # @example
  #
  # Nmax::SeekerIntegers.new(input_data: 'Hello Worlld 2020', count_numbers: 5).seek
  class SeekerIntegers
    MAX_COUNT_DIGIT = 1000

    attr_reader :input_data, :count_numbers

    def initialize(input_data:, count_numbers:)
      raise EmptyInputData if input_data.to_s.chomp.empty?
      raise CountNumbersZero if count_numbers.to_i.zero?
      raise CountNumbeMustBePositive if count_numbers.to_i.negative?

      @input_data = input_data
      @count_numbers = count_numbers
    end

    # @return [Array]
    def search
      # select all numbers from a string
      numbers = @input_data.scan(/\d+/).select do |number|
        number.to_i.is_a?(Integer) && !number.to_i.zero?
      end.map(&:to_i).uniq

      numbers.each { |number| raise InvalidInput if num_digits(number.to_i) > MAX_COUNT_DIGIT }

      raise NotContainNumbers if numbers.length.zero?

      numbers.sort!.reverse!

      # return largest n numbers
      numbers[0..count_numbers - 1]
    end

    private

    def num_digits(digit)
      Math.log10(digit).to_i + 1
    end
  end
end
