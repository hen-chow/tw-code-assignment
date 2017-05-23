require_relative "calculator.rb"

class Translator < Calculator
  # include Calculator
  attr_accessor :new_numerals, :roman_map, :input_type, :currency, :question_type, :response

  def initialize
    # set up an initialize method for the Roman variables
    @roman_map = {
      'M' => 1000,
      'D' => 500,
      'C' => 100,
      'L' => 50,
      'X' => 10,
      'V' => 5,
      'I' => 1
    }
    # set up new object to store new language
    @new_numerals = {}

    @currency = {
      'Gold' => 0,
      'Silver' => 0,
      'Iron' => 0
    }

    # initialize the calculator to use for calculations
    @calculator = Calculator.new
  end

  def check_input(input)

    if input.end_with?('?') # check if it's a question
      @input_type = 'question'

      # call the translate question method
      translate_question(input)

    elsif input =~ /\s[IVXLCDM]{1}$/ # check if input has roman numerals
      @input_type = 'roman'

      # call the roman translator function
      translate_roman(input)

    elsif input =~ /\s(Credits)$/ # check if input ends with currency reference
      @input_type = 'currency'

      # call the currency translator function
      translate_currency(input)

    else
      # if input doesn't fall into any above categories
      response = "I have no idea what you are talking about"
    end
  end

  def translate_question(str)

    matches = str.match(/(?<=is ).+(?=\?)/) # match everything between 'is' and '?'

    new_numerals_str = @new_numerals.keys.join('|')
    currency_str = @currency.keys.join('|')

    if matches == nil

      @response = "I have no idea what you are talking about"

    elsif matches[0] =~ /#{new_numerals_str}/ && matches[0] =~ /#{currency_str}/

      @question_type = "currency_conv"

      # start translating the expression
      question_str = matches[0]

      currency_matches = question_str.match(/(?<currency>#{currency_str})/)
      currency = currency_matches[:currency]

      question_arr = question_str.split(" ")

      # slice the str_arr to only include symbols
      str_arr = question_arr.slice(0, question_arr.index(currency))

      # call the to_roman method to convert
      str_val = to_roman(str_arr)

      result = @calculator.calculate_credits((@currency[currency]), str_val)

      response = "#{question_str}is #{result.floor} Credits"

    elsif  matches[0] =~ /#{new_numerals_str}/ && matches[0] !=~ /#{currency_str}/

      @question_type = "roman_num_conv"

      # start converting new numerals to number values
      question_str = matches[0]

      question_arr = question_str.split(" ")
      question_val = to_roman(question_arr)
      response = "#{question_str}is #{question_val}"

    end
  end

  def translate_roman(str)
    matches = str.match(/(?<symbol>^[a-z]*)\s.*\s(?<value>[A-Z]{1}$)/) # match for symbol ie new numeral name and each roman value

    symbol = matches[:symbol]
    value = matches[:value]
    @new_numerals[symbol] = value

    num_value = to_number(value)
  end

  def translate_currency(str)
    # find the Currency, Overall value and Symbols
    matches = str.match(/(?<currency>[A-Z][a-z]+).*\s(?<number>\d+)\s(Credits$)/)

    if matches[0] == nil

      @response = "There's been a problem"

    else
      currency = matches[:currency]
      overall_value = matches[:number].to_i

      str_arr = str.split(" ")
      # slice the str_arr to only include symbols
      str_arr = str_arr.slice(0, str_arr.index(currency))

      # call the to_roman method to convert
      str_val = to_roman(str_arr)

      # call the calculate_currency method
      currency_val = @calculator.calculate_currency(str_val, overall_value)

      # update new_numerals object with value
      @currency[currency] = currency_val

    end
  end

  def to_roman(arr)
    result = []
    arr.each do |el|
      result.push(@new_numerals[el])
    end
    result = result.join("")

    if result =~ /^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/ # roman numeral validator
      # call the to_number method to convert
      converted_number = to_number(result)
    else
      puts "Not a valid roman numeral"
    end
  end

  def to_number(roman)
    result = 0
    last_number = 0
    roman = roman.split("")
    # reverse loop thru the roman array to work out value
    roman.reverse_each do |el|
      if @roman_map[el] < last_number
        result -= @roman_map[el]
        last_number = @roman_map[el]
      else
        result += @roman_map[el]
        last_number = @roman_map[el]
      end
    end
    result
  end

end
