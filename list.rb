class List
  ########### LIST ALL BOOKS ############
  def list_all_books
    if @book_list.empty?
      puts 'There is no book in the Library'
    else
      @book_list.each_with_index { |book, i| puts "#{i}) Title: #{book.title}, Author: #{book.author}" }
    end
  end

  ########### LIST ALL PEOPLE ############
  def list_all_people
    if @people.empty?
      puts 'There are no people in the Library'
    else
      @people.each_with_index do |person, i|
        puts "#{i}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  ########### CREATE STUDENT ############
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
    @people << student
    save = []
    @people.each do |person|
      save << { name: person.name, id: person.id, age: person.age }
    end
    save_teacher = JSON.generate(save)
    File.write('./people.json', save_teacher.to_s)
    puts 'Student created successfully!'
  end

  ########### CREATE TEACHER ############
  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    save = []
    @people.each do |person|
      save << { name: person.name, id: person.id, age: person.age }
    end
    save_teacher = JSON.generate(save)
    File.write('./people.json', save_teacher.to_s)
    puts 'Teacher created successfully!'
  end

  ########### CREATE BOOK ############
  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @book_list << book
    save = []
    @book_list.each do |bookk|
      save << { title: bookk.title, author: bookk.author }
      save_book = JSON.generate(save)
      File.write('./books.json', save_book.to_s)
      puts 'Book created successfully!'
    end
  end

  ########### CREATE RENTAL ############
  def create_rental
    puts 'Your Library is empty' if @people.empty? && @book_list.empty?
    puts "Select a book from the following list by number:\n"
    list_all_books
    book_index = gets.chomp.to_i
    puts "Select a person from the following list by number (not id):\n"
    list_all_people
    person_index = gets.chomp.to_i
    puts 'Enter a date: e.g 2022/09/28'
    date = gets.chomp
    rental = Rental.new(date, book_list[book_index], people[person_index])
    @rentals << rental
    save = []
    @rentals.each do |rent|
      save << { date: rent.date, book: rent.book.title, person: rent.person.name }
    end
    save_rental = JSON.generate(save)
    File.write('./rentals.json', save_rental)
    puts 'Rental created successfully!'
  end

  ########### LIST ALL RENTALS ############
  def list_all_rentals
    print 'ID of person: '
    person_id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each do |rental|
      if rental.person.id == person_id
        puts "Date: #{rental.date}, Book: '#{rental.book.title}' by #{rental.book.author}"
      end
    end
  end
end
