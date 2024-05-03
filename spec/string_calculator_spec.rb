require 'spec_helper'

# checks for StringCalculator class
describe StringCalculator do
  calc = StringCalculator.new

  context '#add' do
    it "should return 0 on empty string" do
      expect(calc.add("")).to eq(0)
    end

    it "should return 6 on '1,2,3'" do
      expect(calc.add("1,2,3")).to eq(6)
    end

  end
end
