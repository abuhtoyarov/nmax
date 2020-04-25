# frozen_string_literal: true

describe Nmax::SeekerIntegers do
  subject { described_class }

  context 'when data wrong' do
    it 'raise when the maximum number is 0' do
      expect { subject.new(input_data: 'Hello world 2020', count_numbers: 0) }.to raise_error Nmax::CountNumbersZero
    end

    it 'raise when the maximum number is negative' do
      text = 'Hello world 2020'
      count = -5

      expect { subject.new(input_data: text, count_numbers: count) }.to raise_error Nmax::CountNumbeMustBePositive
    end

    it 'raise when the input is empty' do
      text = ''
      count = 5

      expect { subject.new(input_data: text, count_numbers: count) }.to raise_error Nmax::EmptyInputData
    end

    it "raise when the input contains a number greater than #{Nmax::SeekerIntegers::MAX_COUNT_DIGIT} digits" do
      number_too_long = rand(1100**1100).to_s
      count = 5
      text = '50 The 10 three largest 70 numbers will 100 return 90 from this 80 line. 100 ' + number_too_long

      expect { subject.new(input_data: text, count_numbers: count).search }.to raise_error Nmax::InvalidInput
    end

    it 'raise if the input does not contain integers' do
      text = 'Hello world'
      count = 5

      expect { subject.new(input_data: text, count_numbers: count).search }.to raise_error Nmax::NotContainNumbers
    end
  end

  context 'when data correct' do
    it 'return 3 maximum integers' do
      text = '50 The 10 three largest 70 numbers will 100 return 90 from this 80 line. 100'
      count = 3

      expect(subject.new(input_data: text, count_numbers: count).search).to include(80, 90, 100)
    end
  end
end
