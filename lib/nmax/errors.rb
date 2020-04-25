# frozen_string_literal: true

module Nmax
  class Error < StandardError; end

  class EmptyInputData < Error
    def message
      'Input cannot be empty'
    end
  end

  class CountNumbersZero < Error
    def message
      'count numbers cannot be zero'
    end
  end

  class CountNumbeMustBePositive < Error
    def message
      'count numbers must be a positive number'
    end
  end

  class NotContainNumbers < Error
    def message
      'The input does not contain numbers'
    end
  end

  class InvalidInput < Error
    def message
      'Data cannot contain a number longer than 1000 digits'
    end
  end
end
