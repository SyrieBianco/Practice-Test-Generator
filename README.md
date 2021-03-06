# A Refactor of Mallory's Practice Test Generator

[Mallory's Original Practice Test Generator](https://github.com/mallorybulkley/aa-practice-test-generator)

This practice test generator was extremely useful to me as a student, but I was interested in expanding its use cases.

The main adaptation was to make it easier to generate a master list of all of the questions, and allowing the user to have the option to order the questions alphabetically. I did this by:
- Listing the number of available questions in addition to the available categories
- Adding conditional logic to detect if all of the questions have been selected
- Allowing the user to input a y/n response to trigger either randomizing or ordering the data from there

The purpose of this is to be able to create an index of the questions that is easy to cross reference to individual solution and spec files, as well as having the ability to run the combined spec file on all of the tests.

The rest of the refactoring was mostly stylistic:
- re-styling the output files so that they were easier to navigate modularly
- adding the total number of available questions to the terminal interface
- restricting user input and protecting against invalid inputs:
  - separating out question choice into separate inputs
  - validating user input
- re-styling to improve ux; e.g. adding whitespace, coloring and indentation to make the file more legible
- refactoring arrays into hashes to be able to display more information for each category





Mallory's orignal instructions can be found below.
The original repo can be found [here](https://github.com/mallorybulkley/aa-practice-test-generator)


## a/A Practice Test Generator
~ ~ original readme, written by [Mallory Bulkley](https://mallorybulkley.com/) ~ ~

I created this simple CLI practice test generator during my first week at App Academy to help myself and other students prepare for our first assessment. I wanted a way to simulate the actual test rather than just solving practice problems individually. The questions, RSpec tests, and solutions were largely pulled from exercises we had encountered during the prepwork and first week of class, or contributed by other students.


All of the practice problems are listed and categorized in `list.csv` (categories include: recursion, sorting, enumerable, array, string). When you run `generator.rb` on the command line and provide your desired number of questions from each category, it uses your input and the CSV file to randomly select practice problems. It combines these problems and writes 3 new files inside the repo folder:
* `practice_test.rb` contains the problems to be solved
* `spec.rb` combines the specs for the chosen problems into one file for easy testing
* `solutions.rb` combines the solutions for each problem

### How to use this generator

1. Clone this repo

2. Navigate to the folder in terminal and run
`ruby generator.rb`

3. Input your practice test requests in the form `category: # of problems`

4. You will now have three new files: `practice_test.rb`, `spec.rb` and `solutions.rb`. Run `bundle exec rspec spec.rb` to test your answers against the spec as you work through `practice_test.rb`.

5. Check your solutions against those in `solutions.rb`.

Note: if you run the generator again in the same folder, it will re-write those three files and erase your previous work. If you wish to save your previous work, you will need to rename the files.
