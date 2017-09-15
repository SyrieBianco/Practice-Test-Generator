require 'csv'
require 'colorize'

# Instructions
system("clear")
puts
puts "Welcome to Syrie's adaption of Mallory's a/A Practice Assessment Generator".cyan
puts
puts "This generator will create a practice test based on your input. " \
      "You can choose how many problems from each category to include in your test. "
puts
puts "This program will generate 3 files in this folder: practice_test, spec, and solution. " \
      "Complete the practice_test file, running the spec file to check your answers. " \
      "When your time is up (you are timing yourself, right?), compare your answers to the solutions."
puts
puts "Good luck!"
puts

# read in csv with test info
tests = CSV.read('list.csv', headers: true, header_converters: :symbol, converters: :all)

# list possible categories
categories = Hash.new(0)
tests.each do |test|
  categories[test[1]] += 1
end
puts
puts "Possible categories:".magenta

categories.keys.each do |category|
  cat = category.dup
  cat[0] = cat[0].upcase
  puts "   #{cat} — #{categories[category]} available questions"
end
puts puts


# prompt user
puts "Enter how many questions from each category you want in your practice test".cyan
puts "Please enter only an integer".cyan


# get user requests for each category
category_requests = {}

categories.keys.each_with_index do |category, i|

  cat = category.dup
  cat[0] = cat[0].upcase
  num_questions = categories[category]

  puts puts
  puts "Category #{i + 1}: " + "#{cat}".magenta
  puts "#{num_questions} available questions"
  puts
  puts "Number of".green + " #{category} ".green + "questions to add to this test:".green

  input = gets.chomp
  # until they input a valid number of questions, keep updating
  # the input value
  until ("0"..num_questions.to_s).include?(input)
    puts
    # if they did input an integer...
    if input.to_i.to_s == input
      puts "There are only #{num_questions} questions" if input.to_i > num_questions
      puts "You can't have a negative number of questions" if input.to_i < 0
    else
      puts "You must input an integer"
    end

    puts "Please enter a valid number of questions:".light_red
    input = gets.chomp
  end
  # assign the value in the hash to their valid input
  category_requests[category] = input.to_i
end


# make test array for each category
master = Array.new
categories.each do |category|
  problems_in_category = Array.new
  tests.each do |test|
    if category == test[1]
      problems_in_category << test
    end
  end

  # pick tests at random from each category
  n = categoryrequests[category]
  master = master.concat(problems_in_category.sample(n))
end

# create new test, spec and solution files
practice_test = File.open("practice_test.rb", "w")
spec = File.open("spec.rb", "w")
solution = File.open("solution.rb", "w")

# require rspec and the practice_test in the spec
spec << "require 'rspec'" << "\n"
spec << "require_relative 'practice_test'" << "\n"

# loop through master tests and add text to the new files
master.each do |test|
  practice_test << File.read(test[2]) << "\n"
  spec << File.read(test[3]) << "\n"
  solution << File.read(test[4]) << "\n"
end

# close the files that were just created
practice_test.close
spec.close
solution.close

puts
puts "Done!"
