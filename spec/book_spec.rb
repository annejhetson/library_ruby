require 'spec_helper'

describe Book do
  it 'is initialized with a title' do
    test_book = Book.new({:title => "Gone with the Wind"})
    test_book.should be_an_instance_of Book
  end
  it 'returns the title of the book' do
    test_book = Book.new({:title => "Gone with the Wind"})
    test_book.title.should eq 'Gone with the Wind'
  end
  it 'starts off with no books' do
    Book.all.should eq []
  end
  it 'takes a book and saves it into the database' do
    test_book = Book.new({:title => "Gone with the Wind"})
    test_book.save
    Book.all.first.title.should eq "Gone with the Wind"
  end
  describe '.create' do
    it 'initializes and saves a book in the database' do
      test_book = Book.create({:title => "Gone with the Wind"})
      Book.all.first.title.should eq "Gone with the Wind"
    end
  end
  describe '#delete' do
    it 'deletes a book from the database' do
      test_book = Book.create({:title => "Gone with the Wind"})
      Book.all.first.title.should eq "Gone with the Wind"
      test_book.delete
      Book.all.first.should eq nil
    end
  end
  describe '#edit' do
    it 'edit a book from the database' do
      test_book = Book.create({:title => "Gone with the Wind"})
      test_book.edit("50 Shades of Pink")
      Book.all.first.title.should eq "50 Shades of Pink"
    end
  end

  describe '#join_author_title' do
    it 'links author id and title id into book table' do
      test_book = Book.create({:title => "Gone with the Wind"})
      test_author = Author.create({:name => "Margaret Mitchell"})

      test_book.join_author_title(test_author.id)

      # result = DB.exec("SELECT * FROM books WHERE author_id = 7;")
      # result.first['title_id'].to_i.should eq 101
      test_book.author.should eq 'Margaret Mitchell'
    end
  end

  describe '.search' do
    it 'search database for a title or an author' do
      test_book = Book.create({:title => "Gone with the Wind"})
      test_author = Author.create({:name => "Margaret Mitchell"})
      test_book.join_author_title(test_author.id)
      Book.search("Gone")[0].should eq "Gone with the Wind"
      Book.search("Gone")[1].should eq "Margaret Mitchell"
    end
  end
end
