require 'pg'

class Book

  attr_reader :title, :id

  def initialize(input_hash)
    @title = input_hash[:title]
    @id = input_hash[:id]
  end

  def self.all
    results = DB.exec("SELECT * FROM titles;")
    books = []
    results.each do |result|
      title = result['title']
      id = result['id'].to_i
      books << Book.new({:title => title, :id => id})
    end
    books
  end

  def Book.create(input_hash)
      new_book = Book.new(input_hash)
      new_book.save
      new_book
  end

  def author
  DB.exec("SELECT authors.* FROM
         titles join books on (titles.id = books.title_id)
         join authors on (books.author_id = authors.id)
         WHERE titles.id = #{self.id};").first['name']
 end

  def save
    result = DB.exec("INSERT INTO titles (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM titles WHERE id = #{@id}")
  end

  def edit(new_title)
    DB.exec("UPDATE titles SET title = '#{new_title}' WHERE id = #{@id};")
  end

  def join_author_title(author_id)
    DB.exec("INSERT INTO books (title_id, author_id) VALUES (#{@id}, #{author_id});")
  end

  def Book.search(search_term)
    results = DB.exec("SELECT * FROM titles where title LIKE '#{search_term}%';")
    final_results = []
    results.each do |result|
      title = result['title']
      final_results << results.first['title']
    # search_title_id = results.first['id'].to_i
      search_author = DB.exec("SELECT authors.* FROM
         titles join books on (titles.id = books.title_id)
         join authors on (books.author_id = authors.id)
         WHERE titles.id = #{self.id};")
      final_results << search_author.first['name']
    end
    final_results
  end
end

# results.first[:name]

    # final_result = []
    # results.each do |result|
    #     title = result['title']
    #     search_title_id = result['id'].to_i
    #     temp_authors = DB.exec("SELECT authors.* FROM
    #     titles join books on (titles.id = books.title_id)
    #     join authors on (books.author_id = authors.id)
    #     WHERE titles.id = search_title_id;")
    #     final_result << temp_authors.first['name']
    #   end
    #    results.first[:title]
    #    final_result.first[:name]




