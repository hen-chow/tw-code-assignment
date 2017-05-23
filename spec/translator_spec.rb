require_relative "../translator.rb"

describe Translator do
  before (:each) do
    @translator = Translator.new
  end

  describe ".new" do
    it "should have no new terms in it" do
      expect(@translator.new_numerals.length).to eq 0
    end
  end

  describe "#check_input" do
    before do
      @translator.new_numerals = { "glob" => "I" }
    end

    it "checks if input is a question" do
      @translator.check_input("how much is glob glob ?")
      expect(@translator.input_type).to eq 'question'
    end

    it "checks if input has currency reference" do
      @translator.check_input("glob glob Silver is 34 Credits")
      expect(@translator.input_type).to eq 'currency'
    end

    it "checks if input has roman numerals" do
      @translator.check_input("prok is V")
      expect(@translator.input_type).to eq 'roman'
    end

    it "returns error message if input doesn't make sense" do
      expect(@translator.check_input("glob is great")).to eq 'I have no idea what you are talking about'
    end
  end

  describe "#translate_roman" do
    it "translates new currency symbols to number value" do
      expect(@translator.translate_roman("pish is X")).to eq 10
    end

    it "should add store value in new numerals" do
      @translator.translate_roman("pish is X")
      expect(@translator.new_numerals["pish"]).to eq "X"
    end
  end

  describe "#translate_currency" do
    before do
      @translator.new_numerals = { "glob" => "I" }
      @translator.currency = { "Iron" => 1000}
    end

    it "finds the currency value" do
      expect(@translator.translate_currency("glob glob Silver is 34 Credits")).to eq 17
    end

    it "returns the correct currency value" do
      expect(@translator.currency["Iron"]).to eq 1000
    end
  end

  describe "#translate_question" do
    before do
      @translator.new_numerals = { "glob" => "I" }
      @translator.currency = { "Iron" => 1000}
    end

    it "finds question type" do
      @translator.translate_question("how much is glob glob ?")
      expect(@translator.question_type).to eq "roman_num_conv"
    end

    it "finds question type" do
      @translator.translate_question("how many Credits is glob Iron ?")
      expect(@translator.question_type).to eq "currency_conv"
    end

    it "returns error message if can't understand question" do
      @translator.translate_question("how much wood could a woodchuck chuck if a woodchuck could chuck wood ?")
      expect(@translator.response).to eq "I have no idea what you are talking about"
    end
  end

  describe "#to_roman" do
    before do
      @translator.new_numerals = {
        "glob" => "I",
        "prok" => "V",
        "pish" => "X",
        "tegj" => "L"
      }
    end

    it "translates input to roman numerals" do
      expect(@translator.to_roman(["pish", "tegj", "glob", "glob"])).to eq 42
    end
  end

  describe "#to_number" do
    it "converts roman numerals to numbers" do
      expect(@translator.to_number("MCIV")).to eq 1104
    end
  end

  describe "#"

end



# t.check_input "glob is I"
# t.check_input "prok is V"
# t.check_input "pish is X"
# t.check_input "tegj is L"
# t.check_input "glob glob Silver is 34 Credits"
# t.check_input "glob prok Gold is 57800 Credits"
# t.check_input "pish pish Iron is 3910 Credits"
#
# puts t.check_input "how much is pish tegj glob glob ?"
# puts t.check_input "how many Credits is glob prok Silver ?"
# puts t.check_input "how many Credits is glob prok Gold ?"
# puts t.check_input "how many Credits is glob prok Iron ?"
# puts t.check_input "how much wood could a woodchuck chuck if a woodchuck could chuck wood ?"
