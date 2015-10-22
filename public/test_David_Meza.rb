def assert_equal(expected, result)
  p "FAILURE:: expected:#{expected} != result:#{result}" unless expected == result
end

def number_to_words(number)
  numbers_to_words_hash = {
    1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four',
    5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight',
    9 => 'nine', 10 => 'ten',
    11 => 'eleven', 12 => 'twelve', 13 => 'thrirteen', 14 => 'fourteen',
    15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen',
    19 => 'nineteen', 20 => 'twenty', 30 => 'thirty', 40 => 'fourty',
    50 => 'fifty', 60 => 'sixty', 70 => 'seventy', 80 => 'eighty',
    90 => 'ninety'
  }

  # big_values = {4 =>"thousand", 7=>"million", 10=>"billion", 13 => "trillion"}
  big_values = {1 =>"thousand", 2=>"million", 3=>"billion", 4 => "trillion"}

  result = ""
  number.to_s.reverse.scan(/.{1,3}/).each_with_index do |digits, index|
    digits = digits.reverse.to_i
    # p "index:#{index}::digits: #{digits}::#{(decimals = digits % 100)}"
    if (index > 0) #values over next to hundreds
      result = " #{big_values[index]} #{result}"
    end
    if (decimals = digits % 100) > 0
      unless numbers_to_words_hash[decimals].nil?
        result = "#{numbers_to_words_hash[decimals]}#{result}"
      else
        units = decimals % 10
        result = "#{numbers_to_words_hash[decimals]}#{result}" if units == 0
        result = "#{numbers_to_words_hash[decimals - units]}-#{numbers_to_words_hash[units]}#{result}" if units > 0
      end
      # p "d: result:#{result}"
    end
    if digits >= 100 # hundreds
      result = "#{numbers_to_words_hash[digits / 100]} hundred#{" #{result}" unless result.empty?}"
    end
  end
  return result
=begin
  # the basic values
  unless numbers_to_words_hash[number].nil?
    return numbers_to_words_hash[number]
  else # text composed of joining values
    result = ""
    number.to_s.reverse.scan(/./).each_with_index do |digit, index|
      digit = digit.to_i
      index += 1
      if ((index % 3) == 0) # hundreds
        result = "#{numbers_to_words_hash[digit]} hundred #{result}"
      elsif (index > 1 && ((index - 1) % 3) == 0) #values over next to hundreds
        result = "#{numbers_to_words_hash[digit]} #{big_values[index]} #{result}"
      elsif (((index -2) % 3) == 0) # values before hundreds
        digit = digit * 10
        result = "#{numbers_to_words_hash[digit]}-#{result}" if digit > 0
      else # simple digits
        result = "#{numbers_to_words_hash[digit]}#{result}"
      end
    end
    return result
  end
=end
end

assert_equal "one", number_to_words(1)
assert_equal "two", number_to_words(2)
assert_equal "three", number_to_words(3)
assert_equal "ten", number_to_words(10)
assert_equal "fourteen", number_to_words(14)
assert_equal "twenty", number_to_words(20)
assert_equal "twenty-one", number_to_words(21)
assert_equal "thirty-two", number_to_words(32)
assert_equal "fourty-three", number_to_words(43)
assert_equal "fifty-four", number_to_words(54)
assert_equal "sixty-five", number_to_words(65)
assert_equal "seventy-six", number_to_words(76)
assert_equal "eighty-seven", number_to_words(87)
assert_equal "ninety-eight", number_to_words(98)
assert_equal "one hundred nine", number_to_words(109)
assert_equal "one hundred sixteen", number_to_words(116)
assert_equal "nine hundred eighty-seven", number_to_words(987)
assert_equal "two thousand nine hundred nineteen", number_to_words(2919)
assert_equal "five hundred fourty-three thousand nine hundred eighty-seven", number_to_words(543987)
assert_equal "one hundred twenty-three million six hundred fifty-four thousand nine hundred eighty-seven", number_to_words(123654987)
assert_equal "nine hundred thirty-four billion one hundred twenty-three million six hundred fifty-four thousand nine hundred eighty-seven", number_to_words(934123654987)
assert_equal "four hundred seventy-one trillion nine hundred thirty-four billion one hundred twenty-three million six hundred fifty-four thousand nine hundred eighty-seven", number_to_words(471934123654987)

# (1..99999).each do |number|
#   p number_to_words(number)
# end