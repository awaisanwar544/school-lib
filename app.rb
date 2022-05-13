require './book'
require './rental'
require './student'
require './teacher'

class App
  attr_reader :persons, :books, :rentals

  def initialize
    @persons = []
    @books = []
    @rentals = []
  end

  def choose_option(operation)
    case operation
    when '1'
      list_all_books
    when '2'
      list_all_persons
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_all_rentals
    end
    print_options
  end

  def print_options
    puts ''
    puts 'WELCOME TO SCHOOL LIBRARY APP!'
    puts ''
    puts 'Please choose an operation from the following options'
    puts '1  →  List all books'
    puts '2  →  List all persons'
    puts '3  →  Create a person'
    puts '4  →  Create a book'
    puts '5  →  Create a rental'
    puts '6  →  List all rentals for a given person id'
    puts 'q  →  Quit'
    operation = gets.chomp
    exit if operation == 'q'

    choose_option(operation)
  end

  def message(issue, recommendation)
    sleep(0.5)
    puts '.'
    sleep(0.5)
    puts "--------------- #{issue} ---------------"
    sleep(0.5)
    puts '. '
    sleep(0.5)
    puts '. '
    sleep(0.5)
    puts '.'
    sleep(1)
    puts "--------------- #{recommendation}---------------"
    sleep(0.5)
  end

  def list_all_books
    if @books.length.positive?
      @books.each_with_index do |book, index|
        puts "#{index + 1}) Titile: #{book.title}, Author: #{book.author}"
      end
    else
      message('There is no book to display', 'Add some books first')
    end
  end

  def list_all_persons
    if @persons.length.positive?
      @persons.each_with_index do |person, index|
        puts "#{index + 1}) Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    else
      message('There is no person to display', 'Add person profiles first')
    end
  end

  def create_student
    print 'Enter Name: '
    name = gets.chomp
    print 'Enter Age: '
    age = gets.chomp
    print 'Has parent permission? [Y/N]: '
    parent_permission = true && gets.chomp.downcase == 'y'
    print 'Classroom: '
    classroom = gets.chomp
    person = Student.new(age, name, parent_permission, classroom)
    @persons << person
    message('Person created successfullly', 'New student added')
  end

  def create_teacher
    print 'Enter Name: '
    name = gets.chomp
    print 'Enter Age: '
    age = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    person = Teacher.new(age, name, specialization)
    @persons << person
    message('Person created successfullly', 'New Teacher added')
  end

  def create_person
    print 'If you want to create a student [Enter 1] or a teacher [Enter 2]: '
    person_role = gets.chomp
    case person_role
    when '1'
      create_student
    when '2'
      create_teacher
    else
      message('Your selection is invalid', 'Please make a valid selection')
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    message('Book created successfullly', 'Happy Learning')
  end

  def create_rental
    puts 'Select a book from the following list by ID'
    puts ''
    list_all_books
    selected_book = @books[gets.chomp.to_i - 1]
    puts 'Select a person from the following list by serial number'
    puts ''
    list_all_persons
    selected_person = @persons[gets.chomp.to_i - 1]
    print 'Date: '
    date = gets.chomp
    @rentals << selected_person.add_rental(date, selected_book)
    message('New rental created', "Date: #{date}, Rental to: #{selected_person.name}, Book: #{selected_book.title}")
  end

  def list_all_rentals
    print 'Enter person ID: '
    id = gets.chomp.to_i
    person_details = @persons.find { |person| person.id == id }
    if person_details
      puts 'Rentals'
      person_details.rental.each_with_index do |rental, index|
        puts "#{index + 1}) #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
      end
    else
      message('There is no rental to display', 'Please create rental records first')
    end
  end

  def start_app
    option = print_options
    choose_option(option)
  end
end
