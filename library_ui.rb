require './lib/book'
require './lib/author'

DB = PG.connect({:dbname => "library"})

def main_menu

  puts "Welcome to Nerd Library"
  puts "Press 'a' for the AUTHOR menu, 'b' for the BOOK menu or 'x' to EXIT"
  user_input = gets.chomp

  case user_input
  when 'a'
    author_menu
  when 'b'
    book_menu
  when 'x'
    puts "()==[:::::::::::::> Goodbye!!!"
  else
    puts "٩(͡๏̯͡๏)۶ Not a valid option, try again!!"
    main_menu
  end
end

def author_menu
  puts "Here is the Author menu"
  puts "Press 'a' to add an author,
  press 'd' to delete an author,
  press 'e' to edit an author,
  press 'l' to list all the authors
  press 'm' to go back to main menu
  press 'x' to exit"

  user_input = gets.chomp
  case user_input
  when 'a'
    add_author
  when 'd'
    delete_author
  when 'e'
    edit_author
  when 'l'
     list_authors
  when 'm'
    main_menu
  when 'x'
    puts "()==[:::::::::::::> Goodbye!!!"
  else
    puts "٩(͡๏̯͡๏)۶ Not a valid option, try again!!"
    author_menu
  end
end

def book_menu
  # system(clear)
  puts "Here is the book menu"
  puts "Press 'a' to add a book,
  press 'd' to delete a book,
  press 'e' to edit a book,
  press 'l' to list all the books
  press 'm' to go back to main menu
  press 'x' to exit"

  user_input = gets.chomp
  case user_input
  when 'a'
    add_book
  when 'd'
    delete_book
  when 'e'
    edit_book
  when 'l'
     list_books
  when 'm'
    main_menu
  when 'x'
    puts "()==[:::::::::::::> Goodbye!!!"
  else
    puts "٩(͡๏̯͡๏)۶ Not a valid option, try again!!"
    book_menu
  end
end

def list
  puts "============================"
  Book.all.each do |book|
    puts "#{book.id} - #{book.title}"
  end
  puts "============================"
end

def list_books
  system('clear')
  puts "Here is a list of all your books!"
  list
  book_menu
end

def add_book
  puts "Enter the title of the book"
  new_book = gets.chomp
  Book.create({:title => new_book})
  puts "Processing...."
  sleep(1)
  puts "#{new_book} has been added to our Nerd system"
  book_menu
end

def edit_book
  system('clear')
  puts "Here is a list of all books,
  enter the number of the book you want to edit"
  list
  id = gets.chomp.to_i
  puts "Please enter the new title:"
  new_title = gets.chomp
  edit_book = Book.new({:id => id})
  edit_book.edit(new_title)
  results = DB.exec("SELECT * FROM titles WHERE id = id;")
  puts "Processing......."
  sleep(1)
  system('clear')
  puts "Your title has been changed to:"
  puts "#{results.first['id']} - #{results.first['title']}\n\n"
  book_menu
end

def delete_book
  puts "Here is a list of all books"
  list
  puts "enter the number of the book you want to DELETE!!"
  id = gets.chomp.to_i
  delete_book = Book.new({:id => id})
  delete_book.delete
  puts "Processing....."
  sleep(1)
  puts "The book you entered has been successfully deleted\n\n"
  book_menu
end


def list_author
  puts "============================"
  Author.all.each do |author|
    puts "#{author.id} - #{author.name}"
  end
  puts "============================"
end

def list_authors
  system('clear')
  puts "Here is a list of all the authors!"
  list_author
  author_menu
end

def add_author
  puts "Enter the name of the author"
  new_author = gets.chomp
  Author.create({:name => new_author})
  puts "Processing...."
  sleep(1)
  puts "#{new_author} has been added to our Nerd system\n\n"
 author_menu
end

def edit_author
  system('clear')
  puts "Here is a list of all the authors,
  enter the number of the author you want to edit"
  list_author
  id = gets.chomp.to_i
  puts "Please enter the new name:"
  new_name = gets.chomp
  edit_author = Author.new({:id => id})
  edit_author.edit(new_name)
  results = DB.exec("SELECT * FROM authors WHERE id = id;")
  puts "Processing......."
  sleep(1)
  system('clear')
  puts "Your author has been changed to:"
  puts "#{results.first['id']} - #{results.first['name']}\n\n"
  author_menu
end

def delete_author
  puts "Here is a list of all authors"
  list_author
  puts "enter the number of the author you want to DELETE!!"
  id = gets.chomp.to_i
  delete_author = Author.new({:id => id})
  delete_author.delete
  puts "Processing....."
  sleep(1)
  puts "The author you entered has been successfully deleted\n\n"
  author_menu
end
main_menu




