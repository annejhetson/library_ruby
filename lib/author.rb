require 'pg'

class Author

attr_reader :name, :id

  def initialize(input_hash)
    @name = input_hash[:name]
    @id = input_hash[:id]
  end

  def self.all
    results = DB.exec("SELECT * FROM authors;")
    authors = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      authors << Author.new({:name => name, :id => id})
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def Author.create(input_hash)
    new_author = Author.new(input_hash)
    new_author.save
    new_author
  end

  def delete
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end

  def edit(new_author)
    DB.exec("UPDATE authors SET name = '#{new_author}' WHERE id = #{@id};")
  end
end
