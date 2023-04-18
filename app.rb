require_relative 'person'
require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
###############################
require 'json'
require './data'

class App
  attr_accessor :book_list, :people ###############################

  def initialize
    @book_list = []
    @people = []
    @rentals = []
    @students = []
    @teachers = []
  end

  def run_selection
    display_selection
  end

   # ======== Load books=======

   def load_books
    return unless File.exist?('./books.json')

    file = File.read('./books.json')
    data = JSON.parse(file)
    data.each do |book|
      @book_list << Book.new(book['title'], book['author'])
    end
  end

  # ========load people ========
  def load_people
    return unless File.exist?('./people.json')

    file = File.read('./people.json')
    data = JSON.parse(file)
    data.each do |person|
      @people <<
        if person['parent_permission']
          Student.new(person['age'], person['name'], parent_permission: person['parent_permission'])
        else
          Teacher.new(person['age'], person['specialization'], person['name'])
        end
    end
  end

  # =======Load retals =========
  def load_rentals
    return unless File.exist?('./rentals.json')

    file = File.read('./rentals.json')
    data = JSON.parse(file)
    data.each do |rental|
      @rentals << Rental.new(rental['date'], @people.select do |person|
                                               person.name == rental['person']
                                             end.first, @book_list.select do |book|
                                                          book.title == rental['book']
                                                        end.first)
    end
  end

  def list_all_books
    if @book_list.empty?
      puts 'There is no book in the Library'
    else
      @book_list.each_with_index { |book, i| puts "#{i}) Title: #{book.title}, Author: #{book.author}" }
    end
  end

  def list_all_people
    if @people.empty?
      puts 'There are no people in the Library'
    else
      @people.each_with_index do |person, i|
        puts "#{i}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp
    case person_type
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid Options'
      create_person
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N] '
    parent_permission = gets.chomp
    parent_permission = true if parent_permission == 'y'
    parent_permission = false if parent_permission == 'n'
    student = Student.new(age, name, parent_permission)
    @people << student unless @people.include?(student)
    @students << student unless @students.include?(student)
    puts 'Student created successfully!'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @people << teacher unless @people.include?(teacher)
    @teachers << teacher unless @teachers.include?(teacher)
    puts 'Teacher created successfully!'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    puts 'Book created successfully!'
    @book_list << book unless @book_list.include?(book)
  end

  def create_rental
    puts "Select a book from the following list by number:\n"
    list_all_books
    book_index = gets.chomp.to_i
    puts "Select a person from the following list by number (not id):\n"
    list_all_people
    person_index = gets.chomp.to_i
    puts 'Enter a date: e.g 2022/09/28'
    date = gets.chomp
    rental = Rental.new(date, @book_list[book_index], @people[person_index])
    puts 'Rental created successfully!'
    @rentals << rental unless @rentals.include?(rental)
  end

  def list_all_rentals
    print 'ID of person: '
    person_id = gets.chomp.to_i
    rentals = @rentals.filter { |rental| rental.person.id == person_id }
    puts 'Rentals:'
    rentals.each { |rental| puts "Date: #{rental.date}, Book: '#{rental.book.title}' by #{rental.book.author}" }
  end
end
