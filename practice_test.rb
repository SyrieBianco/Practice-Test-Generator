#______________________________________________________________________
# Problem 1: Base Converter
#______________________________________________________________________

# # # be rspec

# Write a recursive method that takes in a base 10 number n and
# converts it to a base b number. Return the new number as a string
#
# E.g. base_converter(5, 2) == "101"
# base_converter(31, 16) == "1f"

def base_converter(num, b)
  digits = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a
  return digits[num] if num < b

  base_converter(num / b, b) + digits[num % b]
end





#______________________________________________________________________
# Problem 2: Binary Search
#______________________________________________________________________

# # # be rspec spec.rb:15 spec.rb:19 spec.rb:27 spec.rb:31 spec.rb:35 spec.rb:39

class Array

  # Write a monkey patch of binary search:
  # E.g. [1, 2, 3, 4, 5, 7].my_bsearch(5) => 4
  def my_bsearch(target, &prc)
    return nil if empty?
    prc ||= Proc.new { |a, b| a <=> b }
    mid_i = length / 2
    left, middle, right = self[0...mid_i], self[mid_i], self[mid_i + 1..-1]

    case prc.call(target, middle)
    when 0
      return mid_i
    when -1
      return left.my_bsearch(target, &prc)
    when 1
      result = right.my_bsearch(target, &prc)
      result ? result + mid_i + 1 : nil
    end
  end

end





#______________________________________________________________________
# Problem 3: Caesar Cipher
#______________________________________________________________________

# # # be rspec spec.rb:46 spec.rb:50 spec.rb:54

# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  letters = ('a'..'z').to_a
  ciphered = ""

  str.chars.each do |ch|
    index = letters.index(ch.downcase)
    if index
      new_i = (shift + letters.index(ch.downcase)) % letters.length
      new_ch = letters[new_i]
      new_ch.upcase! unless ch == ch.downcase
    else
      new_ch = ch
    end
    ciphered << new_ch
  end
  ciphered
end





#______________________________________________________________________
# Problem 4: Deep Dup
#______________________________________________________________________

# # # be rspec spec.rb:67 spec.rb:71

# Using recursion and the is_a? method,
# write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.

def deep_dup(arr)
  arr.map do |el|
    el.is_a?(Array) ? deep_dup(el) : el
  end
end





#______________________________________________________________________
# Problem 5: Digital Root
#______________________________________________________________________

# # # be rspec spec.rb:78 spec.rb:82 spec.rb:95

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)
  return num if num < 10
  result = num
  until result < 10
    result = result % 10 + digital_root(result / 10)
  end
  result
end





#______________________________________________________________________
# Problem 6: Doubler
#______________________________________________________________________

# # # be rspec spec.rb:95

# Write a method that doubles each element in an array
def doubler(array)
  array.map { |e| e * 2 }
end



#______________________________________________________________________
# Problem 7: Dups
#______________________________________________________________________

# # # be rspec spec.rb:109 spec.rb:113 spec.rb:117 spec.rb:121

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    hash, dups = Hash.new { |h, k| h[k] = [] }, {}
    each_with_index do |el, i|
      hash[el] << i
      dups[el] = hash[el] if hash[el].length == 2
    end
    dups
  end

end





#______________________________________________________________________
# Problem 8: Eight Queens
#______________________________________________________________________

# # # be rspec

# CHALLENGE: Eight queens puzzle precursor
#
# Write a recursive method that generates all 8! possible unique ways to
# place eight queens on a chess board such that no two queens are in
# the same board row or column (the same diagonal is OK).
#
# Each of the 8! elements in the return array should be an array of positions:
# E.g. [[0,0], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]]
#
# My solution used 3 method parameters: current_row, taken_columns, and
# positions so far
def eight_queens_possibilities(current_row, taken_columns, positions)

end





#______________________________________________________________________
# Problem 9: Exponent
#______________________________________________________________________

# # # be rspec spec.rb:142 spec.rb:146 spec.rb:150

# return b^n recursively. Your solution should accept negative values
# for n
def exponent(b, n)
  return [1, b][n] if n.abs < 2
  res = b * exponent(b, n.abs - 1)

  n > 0 ? res : 1.0 / res
end





#______________________________________________________________________
# Problem 10: Factorials Rec
#______________________________________________________________________

# # # be rspec spec.rb:157 spec.rb:161 spec.rb:165 spec.rb:170

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(n)
  return [1, 1][0...n] if n <= 2
  prev = factorials_rec(n - 1)
  prev << (n - 1) * prev[-1]
end





#______________________________________________________________________
# Problem 11: Factors
#______________________________________________________________________

# # # be rspec spec.rb:179 spec.rb:183

# Write a method that returns the factors of a number in ascending order.

def factors(n)
  factors, pairs = [], []
  1.upto(Math.sqrt(n).floor) do |i|
    if n % i == 0
      factors.push(i)
      pairs.unshift(n / i)
    end
  end
  factors + pairs
end





#______________________________________________________________________
# Problem 12: Fibs Sum
#______________________________________________________________________

# # # be rspec spec.rb:190 spec.rb:194 spec.rb:198

# Implement a method that finds the sum of the first n
# fibonacci numbers recursively. Assume n > 0
def fibs_sum(n)
  return [0, 1][n] if n < 2
  fibs_sum(n - 1) + fibs_sum(n-2) + 1
end

#______________________________________________________________________
# Problem 13: First Even Numbers Sum
#______________________________________________________________________

# # # be rspec spec.rb:206 spec.rb:210

# return the sum of the first n even numbers recursively. Assume n > 0
def first_even_numbers_sum(n)
  return 0 if n == 0
  first_even_numbers_sum(n - 1) + 2 * n
end





#______________________________________________________________________
# Problem 14: Jumble Sort
#______________________________________________________________________

# # # be rspec spec.rb:217 spec.rb:221 spec.rb:230

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = ('a'..'z').to_a )
  str.chars.sort_by { |ch| alphabet.index(ch.downcase) }.join("")
end





#______________________________________________________________________
# Problem 15: Make Better Change
#______________________________________________________________________

# # # be rspec spec.rb:237 spec.rb:241 spec.rb:245

# make better change problem from class
# make_better_change(24, [10,7,1]) should return [10,7,7]
# make change with the fewest number of coins

# To make_better_change, we only take one coin at a time and
# never rule out denominations that we've already used.
# This allows each coin to be available each time we get a new remainder.
# By iterating over the denominations and continuing to search
# for the best change, we assure that we test for 'non-greedy' uses
# of each denomination.

def make_better_change(value, coins)

end





#______________________________________________________________________
# Problem 16: Median
#______________________________________________________________________

# # # be rspec spec.rb:258 spec.rb:262 spec.rb:266

# Write a method that returns the median of elements in an array
# If the length is even, return the average of the middle two elements
class Array
  def median
  end
end





#______________________________________________________________________
# Problem 17: Merge Sort
#______________________________________________________________________

# # # be rspec spec.rb:274 spec.rb:278 spec.rb:282 spec.rb:286 spec.rb:300

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
  end

  private
  def self.merge(left, right, &prc)
  end
end





#______________________________________________________________________
# Problem 18: My All
#______________________________________________________________________

# # # be rspec

class Array

  def my_all?(&prc)

  end

end





#______________________________________________________________________
# Problem 19: My Any
#______________________________________________________________________

# # # be rspec

class Array

  def my_any?(&prc)

  end

end





#______________________________________________________________________
# Problem 20: My Each
#______________________________________________________________________

# # # be rspec

class Array

  def my_each(&prc)

  end

  def my_each_with_index(&prc)

  end

end





#______________________________________________________________________
# Problem 21: My Each Hash
#______________________________________________________________________

# # # be rspec

class Hash

  # Write a version of my each that calls a proc on each key, value pair
  def my_each(&prc)

  end

end





#______________________________________________________________________
# Problem 22: My Flatten
#______________________________________________________________________

# # # be rspec

class Array

  # Takes a multi-dimentional array and returns a single array of all the elements
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,5]
  def my_flatten

  end

  # Write a version of flatten that only flattens n levels of an array.
  # E.g. If you have an array with 3 levels of nested arrays, and run
  # my_flatten(1), you should return an array with 2 levels of nested
  # arrays
  #
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,[5]]
  def my_controlled_flatten(n)

  end
end





#______________________________________________________________________
# Problem 23: My Inject
#______________________________________________________________________

# # # be rspec

class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil)
  end
end





#______________________________________________________________________
# Problem 24: My Join
#______________________________________________________________________

# # # be rspec

class Array

  def my_join(str = "")

  end

end





#______________________________________________________________________
# Problem 25: My Merge
#______________________________________________________________________

# # # be rspec

class Hash

  # Write a version of merge. This should NOT modify the original hash
  def my_merge(hash2)

  end

end





#______________________________________________________________________
# Problem 26: My Reject
#______________________________________________________________________

# # # be rspec

class Array

  def my_reject(&prc)

  end

end





#______________________________________________________________________
# Problem 27: My Reverse
#______________________________________________________________________

# # # be rspec

class Array

  def my_reverse

  end

end





#______________________________________________________________________
# Problem 28: My Rotate
#______________________________________________________________________

# # # be rspec

class Array

  def my_rotate(num)

  end

end





#______________________________________________________________________
# Problem 29: My Select
#______________________________________________________________________

# # # be rspec

class Array

  def my_select(&prc)

  end

end





#______________________________________________________________________
# Problem 30: My Zip
#______________________________________________________________________

# # # be rspec

class Array

  def my_zip(*arrs)

  end

end





#______________________________________________________________________
# Problem 31: Prime Factorization
#______________________________________________________________________

# # # be rspec

# Write a recursive function that returns the prime factorization of
# a given number. Assume num > 1
#
# prime_factorization(12) => [2,2,3]
def prime_factorization(num)

end

def is_prime?(num)

end





#______________________________________________________________________
# Problem 32: Primes
#______________________________________________________________________

# # # be rspec

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
end

def primes(num)
end





#______________________________________________________________________
# Problem 33: Quicksort
#______________________________________________________________________

# # # be rspec

class Array

  #Write a monkey patch of quick sort that accepts a block
  def my_quick_sort(&prc)

  end

end





#______________________________________________________________________
# Problem 34: Real Words In String
#______________________________________________________________________

# # # be rspec

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)

  end
end





#______________________________________________________________________
# Problem 35: String Include Key
#______________________________________________________________________

# # # be rspec

# Write a recursive method that takes in a string to search and a key string.
# Return true if the string contains all of the characters in the key
# in the same order that they appear in the key.
#
# string_include_key?("cadbpc", "abc") => true
# string_include_key("cba", "abc") => false
def string_include_key?(string, key)

end





#______________________________________________________________________
# Problem 36: Subsets
#______________________________________________________________________

# # # be rspec

#returns all subsets of an array
def subsets(array)

end





#______________________________________________________________________
# Problem 37: Symmetric Substrings
#______________________________________________________________________

# # # be rspec

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
  end
end





#______________________________________________________________________
# Problem 38: Two Sum
#______________________________________________________________________

# # # be rspec

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum

  end
end





#______________________________________________________________________
# Problem 39: Rec Sum
#______________________________________________________________________

# # # be rspec

# Write a recursive method that returns the sum of all elements in an array
def rec_sum(nums)
end





#______________________________________________________________________
# Problem 40: Permutations
#______________________________________________________________________

# # # be rspec

# Write a recursive method that returns all of the permutations of an array
def permutations(array)
end





#______________________________________________________________________
# Problem 41: Bubble Sort
#______________________________________________________________________

# # # be rspec

class Array
  def bubble_sort!(&prc)
  end

  def bubble_sort(&prc)
  end
end





#______________________________________________________________________
# Problem 42: Pig Latinify
#______________________________________________________________________

# # # be rspec

# Write a method that translates a sentence into pig latin. You may want a helper method.
# 'apple' => 'appleay'
# 'pearl' => 'earlpay'
# 'quick' => 'ickquay'
def pig_latinify(sentence)
end





#______________________________________________________________________
# Problem 43: Titleize
#______________________________________________________________________

# # # be rspec

# Write a method that capitalizes each word in a string like a book title
# Do not capitalize words like 'a', 'and', 'of', 'over' or 'the'
def titleize(title)
end
