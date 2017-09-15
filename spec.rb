require 'rspec'
require_relative 'practice_test'
describe "#rec_sum" do
  it "returns the sums of all elements in an array" do
    arr = [1,2,3,4]
    expect(rec_sum(arr)).to eq(10)
  end

  it "returns 0 if the array is empty" do
    expect(rec_sum([])).to eq(0)
  end
end

describe 'first_even_numbers_sum' do

  it "Correctly returns the sum of the first even number" do
    expect(first_even_numbers_sum(1)).to eq(2)
  end

  it "Returns the sum of the first n even numbers" do
    expect(first_even_numbers_sum(6)).to eq(42)
  end

end

require 'yaml'

describe "eight_queens_possibilities" do
  sol = YAML.load_file("./possible_boards.yml").sort
  pos = eight_queens_possibilities(0, [], nil)

  it "Returns an array of the correct_size" do
    expect(pos.length).to eq(sol.length)
  end

  it "Returns the correct positions" do
    expect(pos.sort).to eq(sol)
  end
end

describe "deep_dup" do
  robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
  ]

  copy = deep_dup(robot_parts)

  it "makes a copy of the original array" do
    expect(copy).to eq(robot_parts)
  end

  it "deeply copies arrays" do
    copy[1] << "LEDs"
    expect(robot_parts[1]).to eq(["capacitors", "resistors", "inductors"])
  end
end


describe "#primes" do

  it "returns first five primes in order" do
    expect(primes(5)).to eq([2, 3, 5, 7, 11])
  end

  it "returns an empty array when asked for zero primes" do
    expect(primes(0)).to eq([])
  end
end

describe "my_reverse" do
  a = [ "a", "b", "c", "d" ]

  it "Reverses an array" do
    expect(a.my_reverse).to eq(a.reverse)
  end
end

describe "#dups" do
  it "solves a simple example" do
    expect([1, 3, 0, 1].dups).to eq({ 1 => [0, 3] })
  end

  it "finds two dups" do
    expect([1, 3, 0, 3, 1].dups).to eq({ 1 => [0, 4], 3 => [1, 3] })
  end

  it "finds multi-dups" do
    expect([1, 3, 4, 3, 0, 3].dups).to eq({ 3 => [1, 3, 5] })
  end

  it "returns {} when no dups found" do
    expect([1, 3, 4, 5].dups).to eq({})
  end
end

describe "#factors" do
  it "returns the factors of 10 in order" do
    expect(factors(10)).to eq([1, 2, 5, 10])
  end

  it "returns just two factors for primes" do
    expect(factors(13)).to eq([1, 13])
  end
end

describe "#merge_sort" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].merge_sort).to eq([])
  end

  it "works with an array of one item" do
    expect([1].merge_sort).to eq([1])
  end

  it "sorts numbers" do
    expect(array.merge_sort).to eq(array.sort)
  end

  it "will use block if given" do
    reversed = array.merge_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end
    expect(reversed).to eq([5, 4, 3, 2, 1])
  end

  it "does not modify original" do
    duped_array = array.dup
    duped_array.merge_sort
    expect(duped_array).to eq(array)
  end

  it "calls the merge helper method" do
    expect(Array).to receive(:merge).at_least(:once).and_call_original
    array.merge_sort
  end
end

describe "my_quick_sort" do

  a = (0..8).to_a

  it "Sorts an array of numbers with no duplicates" do
    expect(a.shuffle.my_quick_sort).to eq(a)
  end

  it "Sorts an array of numbers with duplicates" do
    expect([1,2,3,3,9,10,10,17,432].shuffle.my_quick_sort).to eq([1,2,3,3,9,10,10,17,432])
  end

  it "Sorts according to the block passed in" do
    expect(a.shuffle.my_quick_sort{|a,b| b<=>a}).to eq(a.reverse)
  end
end

describe "#bubble_sort!" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].bubble_sort!).to eq([])
  end

  it "works with an array of one item" do
    expect([1].bubble_sort!).to eq([1])
  end

  it "sorts numbers" do
    expect(array.bubble_sort!).to eq(array.sort)
  end

  it "modifies the original array" do
    duped_array = array.dup
    array.bubble_sort!
    expect(duped_array).not_to eq(array)
  end

  it "will use a block if given" do
    sorted = array.bubble_sort! do |num1, num2|
      # order numbers based on descending sort of their squares
      num2**2 <=> num1**2
    end

    expect(sorted).to eq([5, 4, 3, 2, 1])
  end
end

describe "#bubble_sort" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "delegates to #bubble_sort!" do
    expect_any_instance_of(Array).to receive(:bubble_sort!)

    array.bubble_sort
  end

  it "does not modify the original array" do
    duped_array = array.dup
    array.bubble_sort
    expect(duped_array).to eq(array)
  end
end

describe "#jumble_sort" do
  it "defaults to alphabetical order" do
    expect(jumble_sort("hello")).to eq("ehllo")
  end

  it "takes an alphabet array and sorts by that order" do
    alph = ("a".."z").to_a
    hello = "hello".chars.uniq
    alph -= hello
    alphabet = (hello += alph)

    expect(jumble_sort("hello", alphabet)).to eq("hello")
  end

  it "sorts by a reversed alphabet" do
    reverse = ("a".."z").to_a.reverse
    expect(jumble_sort("hello", reverse)).to eq("ollhe")
  end
end

