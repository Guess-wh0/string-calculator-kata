require 'spec_helper'

# checks for StringCalculator class
describe StringCalculator do
  calc = StringCalculator.new

  context '#add' do
    it 'should return 0 on empty string' do
      expect(calc.add('')).to eq(0)
    end

    it 'should return 4 on "4"' do
      expect(calc.add('4')).to eq(4)
    end

    it 'should return 6 on "1,2,3"' do
      expect(calc.add('1,2,3')).to eq(6)
    end

    it 'should return correct sum for string with \n b/w numbers "1,2,\n3,4"' do
      expect(calc.add("1,2,\n3,4")).to eq(10)
    end

    it 'should return correct sum for string with \n as delimiter "1\n2\n3\n4"' do
      expect(calc.add("1\n2\n3\n4")).to eq(10)
    end

    it 'should return correct sum for string with both comma and \n "1,2\n3,4"' do
      expect(calc.add("1,2\n3,4")).to eq(10)
    end

    it 'raises FormatError for "1,2,4,"' do
      expect { calc.add("1,2,4,") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'raises FormatError for "1,2,4,\n\n\n"' do
      expect { calc.add("1,2,4,\n\n\n") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'raises FormatError for "1,2,4, \n\n\n  "' do
      expect { calc.add("1,2,4, \n\n\n  ") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'raises FormatError for "1,2,,4"' do
      expect { calc.add("1,2,,4") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'raises FormatError for "1,2,4,a"' do
      expect { calc.add("1,2,4,a") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'should return 7 for "1,2,4 \n\n\n  "' do
      expect(calc.add("1,2,4 \n\n\n  ")).to eq(7)
    end
  end
end
