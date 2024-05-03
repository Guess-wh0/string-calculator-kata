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

    it 'raises ArgumentError for "1,2,4,"' do
      expect { calc.add("1,2,4,") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'raises ArgumentError for "1,2,4,\n\n\n"' do
      expect { calc.add("1,2,4,\n\n\n") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'raises ArgumentError for "1,2,4, \n\n\n  "' do
      expect { calc.add("1,2,4, \n\n\n  ") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'raises ArgumentError for "1,2,,4"' do
      expect { calc.add("1,2,,4") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'raises ArgumentError for "1,2,4,a"' do
      expect { calc.add("1,2,4,a") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'should return 7 for "1,2,4 \n\n\n  "' do
      expect(calc.add("1,2,4 \n\n\n  ")).to eq(7)
    end

    it 'should recognize delimiter and should return 6 "//;\n1;2;3"' do
      expect(calc.add("//;\n1;2;3")).to eq(6)
    end

    it 'should recognize delimiter and should return 6 "//;\n1; 2\n3"' do
      expect(calc.add("//;\n1; 2\n3")).to eq(6)
    end

    it 'raises ArgumentError for "//;\n1; 2,\n3"' do
      expect { calc.add("//;\n1; 2,\n3") }.to raise_error(ArgumentError, 'Invalid format')
    end

    it 'raises ArguementError for negative numbers' do
      expect { calc.add("//;\n1; 2\n-3") }.to raise_error(ArgumentError, 'negative numbers not allowed -3')
    end

    it 'should return 10 for "//-\n5-2-3"' do
      expect(calc.add("//-\n5-2-3")).to eq(10)
    end

    it 'raises ArguementError for negative numbers' do
      expect { calc.add("//-\n1--2-3") }.to raise_error(ArgumentError, 'negative numbers not allowed -2')
    end
  end

  context '#valid_format?' do
    let(:calculator) { StringCalculator.new }

    context "valid string" do
      before do
        calculator.expression = '1,2,3'
        calculator.delimiter = ','
      end

      it 'should return true' do
        expect(calculator.send(:valid_format?)).to be true
      end
    end

    context "invalid string" do
      before do
        calculator.expression = '1,2,3,'
        calculator.delimiter = ','
      end

      it 'should return true' do
        expect(calculator.send(:valid_format?)).to be false
      end
    end
  end

  context '#positive_validation' do
    let(:calculator) { StringCalculator.new }

    context "valid string" do
      before do
        calculator.expression = '1,2,3'
        calculator.delimiter = ','
      end

      it 'should return true' do
        expect(calculator.send(:positive_validation)).to be nil
      end
    end

    context "invalid string" do
      before do
        calculator.expression = '1,2,-3'
        calculator.delimiter = ','
      end

      it 'should return true' do
        expect { calculator.send(:positive_validation) }.to raise_error(ArgumentError, 'negative numbers not allowed -3')
      end
    end
  end
end
