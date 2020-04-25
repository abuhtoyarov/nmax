# frozen_string_literal: true

describe Nmax::CLI do
  context 'when data correct' do
    it 'correct output' do
      output = fake_stdin('foobar 10 20') do
        ARGV[0] = 2
        described_class.call
      end

      expect(output).to eq "20\n10"
    end
  end

  context 'when data wrong' do
    it 'empty text' do
      output = fake_stdin('') do
        ARGV[0] = 2
        described_class.call
      end

      expect(output).to eq Nmax::EmptyInputData.new.message
    end

    it 'maximum number is 0' do
      output = fake_stdin('Hello 0') do
        ARGV[0] = 0
        described_class.call
      end

      expect(output).to eq Nmax::CountNumbersZero.new.message
    end

    it 'maximum number is negative' do
      output = fake_stdin('Hello 0') do
        ARGV[0] = -1
        described_class.call
      end

      expect(output).to eq Nmax::CountNumbeMustBePositive.new.message
    end

    it 'input does not contain integers' do
      output = fake_stdin('Hello World') do
        ARGV[0] = 1
        described_class.call
      end

      expect(output).to eq Nmax::NotContainNumbers.new.message
    end

    it "input contains a number greater than #{Nmax::SeekerIntegers::MAX_COUNT_DIGIT} digits" do
      number_too_long = rand(1100**1100).to_s

      output = fake_stdin('Hello 0' + number_too_long) do
        ARGV[0] = 4
        described_class.call
      end

      expect(output).to eq Nmax::InvalidInput.new.message
    end
  end

  private

  # helper method
  def fake_stdin(*args)
    $stdin = StringIO.new
    $stdin.puts(args.shift) until args.empty?
    $stdin.rewind
    yield
  ensure
    $stdin = STDIN
  end
end
