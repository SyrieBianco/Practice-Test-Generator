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


# check to see if they requested all possible questions
all_qs = categories.keys.all? { |cat| categories[cat] == category_requests[cat] }

# ask if the user wants the questions in alphabetical order if they
# ask for all possible questions
alpha = false

if all_qs
  puts puts
  puts "You selected to make a test with all of the possible questions"
  puts "Would you like the questions in alphabetical order? [y/n]"
  res = gets.chomp
  until res == "y" || res == "n"
    puts 'Please respond "y" or "n"'
    res = gets.chomp
  end
  alpha = res == "y" ? true : false
end

# make a master list of questions
master = alpha ? tests : Array.new


# if they do not want it aplhabetical, select random questions
unless alpha
  categories.keys.each do |category|
    # make a new array of questions for each category
    problems_in_category = Array.new

    #shovel tests into the array if they belong to the category
    tests.each do |test|
      if category == test[1]
      problems_in_category << test
      end
    end


    # pick tests at random from each category
    num = category_requests[category]
    master = master.concat(problems_in_category.sample(num))
  end
  master = master.shuffle
end


# create new test, spec and solution files
practice_test = File.open("practice_test.rb", "w")
spec = File.open("spec.rb", "w")
solution = File.open("solution.rb", "w")

# require rspec and the practice_test in the spec
spec << "require 'rspec'" << "\n"
spec << "require_relative 'practice_test'" << "\n"

# set up file format

def format_name(snake_case_name, i)
  split = snake_case_name.split("_")
  formatted = split.each { |word| word[0] = word[0].upcase }.join(" ")

  "Problem #{i + 1}: #{formatted}"
end

def format_file(file, test, file_i, test_i)
  formatted_name = format_name(test[0], test_i)
  file << "#______________________________________________________________________" << "\n"
  file << "# #{formatted_name}" << "\n"
  file << "#______________________________________________________________________" << "\n"
  file << "\n\n"
  file << File.read(test[file_i]) << "\n"
  file << "\n\n\n\n"
end


# loop through master tests and add text to the new files
master.each_with_index do |test, i|
  format_file(practice_test, test, 2, i)
  format_file(solution, test, 4, i)
  spec << File.read(test[3]) << "\n"
end


# close the files that were just created
practice_test.close
spec.close
solution.close

puts
puts "Done!"
