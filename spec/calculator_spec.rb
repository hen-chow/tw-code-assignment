require_relative "../calculator.rb"

describe Calculator do
  before (:each) do
    @calculator = Calculator.new
  end

  describe "#calculate_currency" do
    it "should take overall value and numeral value to return a currency value" do
      expect(@calculator.calculate_currency(5, 100)).to eq 20
    end
  end

  describe "#calculate_credits" do
    it "should take currency value and numeral value to return an overall number of credits" do
      expect(@calculator.calculate_credits(2500, 22)).to eq 55000
    end
  end
end
