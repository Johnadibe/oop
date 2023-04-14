require_relative 'app'

def main
  puts "Welcome to School library App!\n"
  app = App.new
  app.run_selection
end

def list_holder(option)
  case option
  when 1
    list_all_books
  when 2
    list_all_people
  when 3
    create_person
  when 4
    create_book
  when 5
    create_rental
  when 6
    list_all_rentals
  end
end

def display_selection
  puts "Please choose an option by entering a number from below:\n"
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'

  option = gets.chomp.to_i
  list_holder(option)
  if option == 7
    puts 'Thank you for using this app!'
  else
    display_selection
  end
end

main
