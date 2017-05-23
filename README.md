# README

# TITLE: Thoughtworks code test submission - Hen Chow

# Problem Three: Merchant's Guide to the Galaxy
You decided to give up on earth after the latest financial collapse left 99.99% of the earth's
population with 0.01% of the wealth. Luckily, with the scant sum of money that is left in your account,
you are able to afford to rent a spaceship, leave earth, and fly all over the galaxy to sell common
metals and dirt (which apparently is worth a lot).
Buying and selling over the galaxy requires you to convert numbers and units, and you decided to
write a program to help you.
The numbers used for intergalactic transactions follows similar convention to the roman numerals
and you have painstakingly collected the appropriate translation between them.
Roman numerals are based on seven symbols:
Symbol Value
I 1
V 5
X 10
L 50
C 100
D 500
M 1,000
Numbers are formed by combining symbols together and adding the values. For example, MMVI is
1000 + 1000 + 5 + 1 = 2006. Generally, symbols are placed in order of value, starting with the
largest values. When smaller values precede larger values, the smaller values are subtracted from
the larger values, and the result is added to the total. For example MCMXLIV = 1000 + (1000 ­ 100) + (50 ­ 10) + (5 ­ 1) = 1944.
- The symbols "I", "X", "C", and "M" can be repeated three times in succession, but no more.
(They may appear four times if the third and fourth are separated by a smaller value, such as
XXXIX.) "D", "L", and "V" can never be repeated.
- "I" can be subtracted from "V" and "X" only. "X" can be subtracted from "L" and "C" only. "C"
can be subtracted from "D" and "M" only. "V", "L", and "D" can never be subtracted.
- Only one small­value symbol may be subtracted from any large­value symbol.
- A number written in Arabic numerals can be broken into digits. For example, 1903 is
composed of 1, 9, 0, and 3. To write the Roman numeral, each of the non­zero digits should
be treated separately. In the above example, 1,000 = M, 900 = CM, and 3 = III. Therefore,
1903 = MCMIII.
(Source: Wikipedia (http://en.wikipedia.org/wiki/Roman_numerals)
Input to your program consists of lines of text detailing your notes on the conversion between
intergalactic units and roman numerals.

You are expected to handle invalid queries appropriately.

Test input:
glob is I
prok is V
pish is X
tegj is L
glob glob Silver is 34 Credits
glob prok Gold is 57800 Credits
pish pish Iron is 3910 Credits
how much is pish tegj glob glob ?
how many Credits is glob prok Silver ?
how many Credits is glob prok Gold ?
how many Credits is glob prok Iron ?
how much wood could a woodchuck chuck if a woodchuck could chuck wood ?

Test Output:
pish tegj glob glob is 42
glob prok Silver is 68 Credits
glob prok Gold is 57800 Credits
glob prok Iron is 782 Credits
I have no idea what you are talking about

# Overview
I selected to create a solution for this problem using the Ruby language because of several reasons: a) it is my favourite language, b) its cleaner syntax is easier to read along with the regular expressions used for the parsing and c) it has some great simple functions to use on strings and arrays which will help to translate the inputs.

I took an approach of separation of concerns by building a class object to address the Translation function, and one to purely deal with the Calculation.

The parsing Translation library was pulled out because if this language structure is a common structure, it is very likely that reusability is going to be a priority for code development to allow for upgrade and expansion by either myself or the team.

Similarly the Calculation class also allows for extension and can be referenced/accessed by other language libraries (those which may have a different language structure for instance) to use to calculate and convert.

The Translation component is structured based on first checking of input to identify if it is a question (which will then require a response), a simple new numeral language input (which will then be stored in the new numeral object for later reference) or an input involving currencies (which will be used for future calculations). Once the input type has been checked, it is then directed to either store it in the new numeral object, calculate the currency value or sent to the question method to further parse the question to work out what type of question it is.

Since I can't use any Gems/libraries for this task, I've created a translator based on the very structure and syntax/pattern supplied in the test input and output. Therefore should the language syntax gets modified, the parsing code will need to be modified to cater for that.

In addition to that, I have also assumed that user will first input general information about the new numeral language (ie its Roman numeral value), then followed by its information in relation to currency. Currencies are assumed to be Gold, Silver and Iron - however user can input additional currencies which will be stored in the currency object for future calculations.

# Testing
Testing spec files have been created to test scenarios with matching expectations for corresponding Translator and Calculator components. RSpec was used to run and develop tests.

Tests against provided input and output were ran in `output.rb`

To run the test files `translator_spec.rb` and `calculator_spec.rb`, please install RSpec
```gem install rspec
rspec
```

# How to run the application
A file with the supplied test input and output info is saved in the application `output.rb`. You can also paste different test input in the same file to test the application. To run the application:
```ruby output.rb
```

## Specifications
* System dependencies
- RSpec was used to develop test suite
